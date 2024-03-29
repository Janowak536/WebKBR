import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class ClientOrderPage extends StatefulWidget {
  @override
  _ClientOrderPageState createState() => _ClientOrderPageState();
}

class _ClientOrderPageState extends State<ClientOrderPage> {
  final ApiService apiClient = ApiService();
  final TextEditingController _orderIdController = TextEditingController();
  Map<int, List<dynamic>> _originalOrders = {};
  Map<int, List<dynamic>> _displayedOrders = {};
  bool _isLoading = false;
  List<String> orderStatuses = [
    'W trakcie realizacji',
    'Przyjęte do realizacji',
    'Wysłane',
    'Zakończone',
    'Anulowane',
  ];
  Map<int, String> _selectedStatuses = {};
  Map<int, dynamic> _orderStatusAndValues = {};
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
    _fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () {
          if (authProvider.isLoggedIn) {
            authProvider.logout();
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _orderIdController,
                      textAlign: TextAlign.center,
                      decoration:
                          InputDecoration(hintText: 'Podaj numer zamówienia'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: _filterOrders,
                    child: Text(
                      'Szukaj',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Column(
                          children: _displayedOrders.entries.map((entry) {
                            int orderId = entry.key;
                            String status = _orderStatusAndValues[orderId]
                                    ?['status'] ??
                                'Brak';
                            String value = _orderStatusAndValues[orderId]
                                        ?['orderValue']
                                    ?.toString() ??
                                'Brak';
                            _selectedStatuses.putIfAbsent(
                                orderId, () => orderStatuses[0]);

                            return Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('NUMER ZAMÓWIENIA: $orderId ',
                                          style: TextStyle(fontSize: 16)),
                                      Spacer(),
                                      if (_isAdmin) ...[
                                        DropdownButton<String>(
                                          value: _selectedStatuses[orderId],
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                _selectedStatuses[orderId] =
                                                    newValue;
                                              });
                                            }
                                          },
                                          items: orderStatuses
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.orange),
                                          onPressed: () =>
                                              _updateOrderStatus(orderId),
                                          child: Text(
                                            'Zmień status',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () =>
                                              _deleteOrder(orderId),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text('STATUS: $status ',
                                      style: TextStyle(fontSize: 16)),
                                  Text('WARTOŚĆ: $value zł ',
                                      style: TextStyle(fontSize: 16)),
                                  ...entry.value.map((orderItem) {
                                    int productId = orderItem['productId'];
                                    int clientId = orderItem['clientId'] ?? 0;
                                    int modelId = orderItem['modelId'] ?? 0;
                                    int colorId = orderItem['colorId'] ?? 0;
                                    int mdfId = orderItem['mdfId'] ?? 0;
                                    int width = orderItem['width'] ?? 0;
                                    int height = orderItem['height'] ?? 0;

                                    return ListTile(
                                      title: Text(
                                          'Id produktu: $productId Id klienta: $clientId Id modelu: $modelId Id koloru: $colorId Id mdf: $mdfId szerokość: $width wysokość: $height '),
                                      trailing: _isAdmin
                                          ? IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () =>
                                                  _deleteOrderItem(productId),
                                            )
                                          : null,
                                    );
                                  }).toList(),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _originalOrders.clear();
      _displayedOrders.clear();
      _orderStatusAndValues.clear();
    });

    try {
      bool isAdminUser = await apiClient.isAdmin();
      int clientId = await apiClient.getCurrentUser();

      var orders = isAdminUser
          ? await apiClient.getOrder()
          : await apiClient.getOrderByClientId(clientId);

      var statusAndValueFutures = <Future>[];

      for (var order in orders) {
        _originalOrders.putIfAbsent(order['orderId'], () => []).add(order);
        statusAndValueFutures.add(
          apiClient.getOrderStatusAndValue(order['orderId']).then(
            (statusAndValue) {
              if (statusAndValue != null) {
                _orderStatusAndValues[order['orderId']] = statusAndValue;
              }
            },
          ),
        );
      }

      await Future.wait(statusAndValueFutures);

      _displayedOrders = Map.fromEntries(
        _originalOrders.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)),
      );
    } catch (e) {
      print('Błąd podczas pobierania zamówień $e');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterOrders() {
    int? orderId = int.tryParse(_orderIdController.text);
    if (orderId != null) {
      setState(() {
        _displayedOrders = {
          _displayedOrders.keys.firstWhere((k) => k == orderId,
              orElse: () => -1): _displayedOrders[orderId] ?? []
        };
      });
    } else {
      setState(() {
        _displayedOrders = Map.from(_originalOrders);
      });
    }
  }

  void _checkAdminStatus() async {
    bool isAdmin = await apiClient.isAdmin();
    setState(() {
      _isAdmin = isAdmin;
    });
  }

  void _updateOrderStatus(int orderId) async {
    String? newStatus = _selectedStatuses[orderId];
    if (newStatus != null) {
      await apiClient.updateOrderStatus(orderId, newStatus);
      _fetchOrders();
    }
  }

  void _deleteOrder(int orderId) async {
    await apiClient.deleteOrder(orderId);
    _fetchOrders();
  }

  void _deleteOrderItem(int productId) async {
    await apiClient.deleteOrderItem(productId);
    _fetchOrders();
  }
}
