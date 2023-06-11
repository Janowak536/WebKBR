import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                                Text('Grubość frontu meblowego'),
                                DropdownButton<int>(
                                  value: widget.order.thickness,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      widget.order = widget.order
                                          .copyWith(thickness: newValue!);
                                    });
                                  },
                                  items: <DropdownMenuItem<int>>[
                                    DropdownMenuItem<int>(
                                      value: 2,
                                      child: Text('2'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 4,
                                      child: Text('4'),
                                    ),
                                    DropdownMenuItem<int>(
                                      value: 6,
                                      child: Text('6'),
                                    ),
                                  ],
                                ),
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
                                  orders.add(
                                    widget.order
                                        .copyWith(height: height, width: width),
                                  );
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
                      'Wzór: ${order.pattern}, Kolor: ${order.color}, Grubość: ${order.thickness}, Wysokość: ${order.height}, Szerokość: ${order.width}, Typ: ${order.type}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          orders.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            )
          ],
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
}
