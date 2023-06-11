import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Wybierz grubość parapetów',
                  ),
                  DropdownButton<int>(
                    value: widget.order.thickness,
                    onChanged: (int? newValue) {
                      setState(() {
                        widget.order =
                            widget.order.copyWith(thickness: newValue!);
                      });
                    },
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(
                        value: 2,
                        child: Text('19 Finsa Wilgocioodporna'),
                      ),
                      DropdownMenuItem<int>(
                        value: 4,
                        child: Text('22 Finsa Wilgocioodporna'),
                      ),
                      DropdownMenuItem<int>(
                        value: 6,
                        child: Text('25 Finsa Wilgocioodporna'),
                      ),
                      DropdownMenuItem<int>(
                        value: 8,
                        child: Text('30 Finsa Wilgocioodporna'),
                      ),
                    ],
                  ),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      labelText: "Wysokość",
                      hintText: "Wprowadź wysokość",
                    ),
                  ),
                  TextField(
                    controller: widthController,
                    decoration: InputDecoration(
                      labelText: "Szerokość",
                      hintText: "Wprowadź szerokość",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final height = int.tryParse(heightController.text) ?? 0;
                        final width = int.tryParse(widthController.text) ?? 0;
                        orders.add(
                          widget.order.copyWith(height: height, width: width),
                        );
                        heightController.clear();
                        widthController.clear();
                      });
                    },
                    child: Text('Dodaj do listy'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text(
                      'Wzór: ${order.pattern}, Kolor: ${order.color}, Grubość: ${order.thickness}, Wysokość: ${order.height}, Szerokość: ${order.width}',
                    ),
                  );
                },
              ),
            ),
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
