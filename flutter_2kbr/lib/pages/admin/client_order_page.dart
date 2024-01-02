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

  void _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _originalOrders = {}; // Reset original orders
      _displayedOrders = {}; // Reset displayed orders
    });

    try {
      var allOrders = await apiClient.getOrder();
      for (var order in allOrders) {
        _originalOrders.putIfAbsent(order['orderId'], () => []).add(order);
      }
      _displayedOrders =
          Map.from(_originalOrders); // Initially, display all orders

      // Sort the grouped orders by orderId
      var sortedEntries = _displayedOrders.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      _displayedOrders = {
        for (var entry in sortedEntries) entry.key: entry.value
      };
    } catch (e) {
      print('Error fetching orders: $e');
      // Optionally show a dialog or a snackbar with the error message
    }

    setState(() {
      _isLoading = false;
    });
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
      // If no orderId is entered, display all orders
      setState(() {
        _displayedOrders = Map.from(_originalOrders);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Fetch all orders on initial load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
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
                            return Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: entry.value.map((order) {
                                  return ListTile(
                                    title:
                                        Text('Order ID: ${order['orderId']}'),
                                    subtitle: Text(
                                        'Order Details: ${order['details']}'), // Customize based on your data structure
                                  );
                                }).toList(),
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
}
