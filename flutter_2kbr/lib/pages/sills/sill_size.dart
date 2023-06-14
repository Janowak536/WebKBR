import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/mdf.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/pages/cart_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class SillSizePage extends StatefulWidget {
  Order order;

  SillSizePage({required this.order});

  @override
  _SillSizePageState createState() => _SillSizePageState();
}

class _SillSizePageState extends State<SillSizePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    List<Mdf> mdfItems = [
      Mdf(id: 18, name: 'MDF 18'),
      Mdf(id: 19, name: 'FINSA 19'),
      Mdf(id: 22, name: 'MDF 22'),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () => authProvider.isLoggedIn
              ? authProvider.logout()
              : _navigateToLogin(),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: Opacity(
                  opacity: 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                Text('Grubość Sill meblowego'),
                                DropdownButton<Mdf>(
                                  value: mdfItems.firstWhere(
                                      (item) => item.id == widget.order.mdfId),
                                  onChanged: (Mdf? newValue) {
                                    setState(() {
                                      widget.order = widget.order.copyWith(
                                          mdfId: newValue!.id,
                                          mdf: newValue.name);
                                    });
                                  },
                                  items: mdfItems
                                      .map<DropdownMenuItem<Mdf>>((Mdf item) {
                                    return DropdownMenuItem<Mdf>(
                                      value: item,
                                      child: Text(item.name),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('Wysokość'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: TextFormField(
                                    controller: heightController,
                                    decoration: InputDecoration(
                                      hintText: "Wprowadź wysokość",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('Szerokość'),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: TextFormField(
                                    controller: widthController,
                                    decoration: InputDecoration(
                                      hintText: "Wprowadź szerokość",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  final height =
                                      int.tryParse(heightController.text) ?? 0;
                                  final width =
                                      int.tryParse(widthController.text) ?? 0;
                                  Order newOrder = widget.order.copyWith(
                                      height: height,
                                      width: width,
                                      type: "sill");
                                  orders.add(newOrder);
                                  addOrder(newOrder);
                                  heightController.clear();
                                  widthController.clear();
                                });
                              },
                              child: Text('Dodaj do listy'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                            ),
                          )),
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text(
                      'Wzór: ${order.model}, Kolor: ${order.color}, MDF: ${order.mdf}, Wysokość: ${order.height}, Szerokość: ${order.width}, Typ: ${order.type}',
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
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 20.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.navigate_next),
                    onPressed: () => _navigateToCartPage(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void addOrder(Order order) {
    List<Order> ordersFromStorage = getOrdersFromStorage();
    ordersFromStorage.add(order);
    html.window.localStorage['orders'] = jsonEncode(ordersFromStorage
        .map<Map<String, dynamic>>((order) => order.toJson())
        .toList());
  }

  void removeOrder(Order order) {
    List<Order> ordersFromStorage = getOrdersFromStorage();
    ordersFromStorage.removeWhere((o) =>
        o.model == order.model &&
        o.color == order.color &&
        o.mdf == order.mdf &&
        o.height == order.height &&
        o.width == order.width &&
        o.type == order.type &&
        o.modelId == order.modelId &&
        o.colorId == order.colorId &&
        o.mdfId == order.mdfId);
    html.window.localStorage['orders'] = jsonEncode(ordersFromStorage
        .map<Map<String, dynamic>>((order) => order.toJson())
        .toList());
  }

  List<Order> getOrdersFromStorage() {
    String? ordersFromStorage = html.window.localStorage['orders'];
    if (ordersFromStorage != null) {
      List<dynamic> decodedData = jsonDecode(ordersFromStorage);
      return decodedData.map<Order>((item) => Order.fromJson(item)).toList();
    }
    return [];
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

  void _navigateToCartPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => CartPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }
}
