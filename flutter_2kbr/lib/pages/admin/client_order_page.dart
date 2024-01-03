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

  @override
  void initState() {
    super.initState();
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _orderIdController,
                    decoration: InputDecoration(hintText: 'Enter Order ID'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: _filterOrders,
                  child: Text('Search'),
                ),
              ],
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
                                'Status not found';
                            String value = _orderStatusAndValues[orderId]
                                        ?['orderValue']
                                    ?.toString() ??
                                'Value not found';
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
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text('Order ID: $orderId')),
                                      Text('Status: $status'),
                                      Text('Value: $value'),
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
                                        onPressed: () =>
                                            _updateOrderStatus(orderId),
                                        child: Text('Zmień status'),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => _deleteOrder(orderId),
                                      ),
                                    ],
                                  ),
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
                                          'productId: $productId clientId: $clientId modelId: $modelId colorId: $colorId mdfId: $mdfId width: $width height: $height '),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () =>
                                            _deleteOrderItem(productId),
                                      ),
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
      var allOrders = await apiClient.getOrder();
      var statusAndValueFutures = <Future>[];

      for (var order in allOrders) {
        _originalOrders.putIfAbsent(order['orderId'], () => []).add(order);

        // Fetch the status and value for each order and add it to the _orderStatusAndValues map
        var future = apiClient.getOrderStatusAndValue(order['orderId']).then(
          (statusAndValue) {
            print(
                'Fetched status and value for order ID ${order['orderId']}: $statusAndValue'); // Debug print
            if (statusAndValue != null) {
              _orderStatusAndValues[order['orderId']] = statusAndValue;
              // Print each order with its status to the console
              print('Order ID: ${order['orderId']}, '
                  'Status: ${statusAndValue['status']}, ' // Ensure the key is correct
                  'Value: ${statusAndValue['orderValue']}'); // Ensure the key is correct
            } else {
              print(
                  'Status and value for order ID ${order['orderId']} are null');
            }
          },
        );
        statusAndValueFutures.add(future);
      }

      // Wait for all the futures to complete
      await Future.wait(statusAndValueFutures);

      // Sort the orders by orderId
      _displayedOrders = Map.fromEntries(
        _originalOrders.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)),
      );
    } catch (e) {
      print('Error fetching orders: $e');
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
