import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    String? ordersFromStorage = html.window.localStorage['orders'];
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
                    'Wzór: ${order.model}, Kolor: ${order.color}, Grubość: ${order.mdf}, Wysokość: ${order.height}, Szerokość: ${order.width}, Typ: ${order.type}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        removeOrder(order);
                        orders.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
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
    orders.removeWhere((o) =>
        o.model == order.model &&
        o.color == order.color &&
        o.mdf == order.mdf &&
        o.height == order.height &&
        o.width == order.width &&
        o.type == order.type &&
        o.modelId == order.modelId &&
        o.colorId == order.colorId &&
        o.mdfId == order.mdfId);
    html.window.localStorage['orders'] = jsonEncode(
        orders.map<Map<String, dynamic>>((order) => order.toJson()).toList());
  }
}
