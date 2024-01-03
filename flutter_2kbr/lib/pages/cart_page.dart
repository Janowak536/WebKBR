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
    calculateJsonData();
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
                          'MODEL: ${order.model}, MDF: ${order.mdf}, KOLOR: ${order.color}, WYSOKOŚĆ: ${order.height}, SZEROKOŚĆ: ${order.width}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeOrder(order);
                            calculateJsonData();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  sendJsonData();
                },
                child: Text(
                  'Złóż zamówienie',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (orderValue > 0) SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Wycena zamówienia: ${orderValue.toStringAsFixed(2)}zł',
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
        calculateJsonData();
      }
    });
  }

  void sendJsonData() async {
    final apiService = ApiService();
    bool success = await apiService.sendJsonData(orders);

    if (success) {
      setState(() {
        orders.clear();
        orderValue = 0;
        totalValue = 0;
        window.localStorage.remove('orders');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Zamówienie wysłane pomyślnie!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wysłanie zamówienia nie powiodło się.')),
      );
    }
  }

  void calculateJsonData() async {
    final apiService = ApiService();
    await apiService.calculateJsonData(orders).then((value) {
      setState(() {
        orderValue = value;
      });
    });
  }
}
