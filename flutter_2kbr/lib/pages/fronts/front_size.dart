import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/mdf.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/pages/cart_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class FrontSizePage extends StatefulWidget {
  Order order;

  FrontSizePage({required this.order});

  @override
  _FrontSizePageState createState() => _FrontSizePageState();
}

class _FrontSizePageState extends State<FrontSizePage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  List<Order> orders = [];
  List<Mdf> mdfItems = [
    Mdf(id: 1, name: '19 Finsa Wilgocioodporna'),
    Mdf(id: 2, name: '22 Finsa Wilgocioodporna'),
    Mdf(id: 3, name: '25 Finsa Wilgocioodporna'),
    Mdf(id: 4, name: '30 Finsa Wilgocioodporna'),
  ];
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return PopScope(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: [
                              Text('Grubość frontu meblowego'),
                              DropdownButton<Mdf>(
                                value: mdfItems.firstWhere(
                                  (item) => item.id == widget.order.mdfId,
                                  orElse: () => mdfItems[0],
                                ),
                                onChanged: (Mdf? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      widget.order.mdfId = newValue.id;
                                    });
                                  } else {
                                    setState(() {
                                      widget.order.mdfId = 1;
                                    });
                                  }
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
                                width: MediaQuery.of(context).size.width * 0.2,
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
                                width: MediaQuery.of(context).size.width * 0.2,
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
                                    type: "front");
                                addOrderToList(newOrder);
                                heightController.clear();
                                widthController.clear();
                                print(jsonEncode(newOrder.toJson()));
                              });
                            },
                            child: Text(
                              'Dodaj do listy',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                          ),
                        )),
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: EdgeInsets.only(top: 8.0, left: 18.0, right: 18.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.event_seat),
                      title: Text(
                        'modelId: ${order.modelId}, colorId: ${order.colorId}, mdfId: ${order.mdfId}, height: ${order.height}, width: ${order.width}, type: ${order.type}',
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            removeOrderFromList(order);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: Text(
                        'Dodaj listę do koszyka',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        addOrder(orders);
                        _navigateToCartPage();
                      }),
                ))
          ],
        ),
      ),
    );
  }

  void addOrder(List<Order> orders) {
    List<Order> ordersFromStorage = getOrdersFromStorage();
    ordersFromStorage.addAll(orders);
    html.window.localStorage['orders'] = jsonEncode(ordersFromStorage
        .map<Map<String, dynamic>>((order) => order.toJson())
        .toList());
  }

  void addOrderToList(Order order) {
    orders.add(order);
  }

  void removeOrderFromList(Order order) {
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
