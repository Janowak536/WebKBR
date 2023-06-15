import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = [];
  double totalValue = 0;
  double orderValue = 0;

  @override
  void initState() {
    super.initState();
    String? ordersFromStorage = window.localStorage['orders'];
    if (ordersFromStorage != null) {
      List<dynamic> decodedData = jsonDecode(ordersFromStorage);
      orders = decodedData.map<Order>((item) => Order.fromJson(item)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () => authProvider.isLoggedIn
            ? authProvider.logout()
            : _navigateToLogin(),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: ListTile(
                        leading: Icon(order.type == 'front'
                            ? Icons.event_seat
                            : Icons.border_all),
                        title: Text(
                          'modelId: ${order.modelId}, colorId: ${order.colorId}, mdfId: ${order.mdfId}, height: ${order.height}, width: ${order.width}, type: ${order.type}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeOrder(order);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  sendJsonData();
                },
                child: Text('Wyślij JSON'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final apiService = ApiService();
                  final double calculatedValue =
                      await apiService.calculateJsonData(orders);
                  setState(() {
                    orderValue = calculatedValue;
                  });
                },
                child: Text('Podaj wycenę'),
              ),
              if (orderValue > 0) SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Wycena zamówienia: ${orderValue.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void removeOrder(Order order) {
    bool removed = false;
    setState(() {
      orders.removeWhere((o) {
        if (!removed &&
            o.model == order.model &&
            o.color == order.color &&
            o.mdf == order.mdf &&
            o.height == order.height &&
            o.width == order.width &&
            o.type == order.type &&
            o.modelId == order.modelId &&
            o.colorId == order.colorId &&
            o.mdfId == order.mdfId) {
          removed = true;
          return true;
        } else {
          return false;
        }
      });
      if (removed) {
        window.localStorage['orders'] = jsonEncode(orders
            .map<Map<String, dynamic>>((order) => order.toJson())
            .toList());
      }
    });
  }

  void sendJsonData() async {
    final apiService = ApiService();
    await apiService.sendJsonData(orders);
  }

  void calculateJsonData() async {
    final apiService = ApiService();
    await apiService.calculateJsonData(orders);
  }
}
