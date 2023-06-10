import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/color.dart'; // Zaimportuj swój model Color
import 'package:flutter_2kbr/pages/fronts/front_size.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class FrontColorPage extends StatefulWidget {
  Order order;

  FrontColorPage({required this.order});

  @override
  _FrontColorPageState createState() => _FrontColorPageState();
}

class _FrontColorPageState extends State<FrontColorPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final List<ColorModel> colors = [
      ColorModel(name: "Czerwony", image: 'assets/colors/red.jpg'),
      ColorModel(name: "Niebieski", image: 'assets/colors/blue.jpg'),
      // Dodaj więcej kolorów
    ];
    var size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width > 800 ? size.width * 0.2 : 0.9;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CustomAppBar(
            onActionPressed: () => authProvider.isLoggedIn
                ? authProvider.logout()
                : _navigateToLogin(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Wybierz kolor frontu meblowego',
                  style: TextStyle(
                    color: Color.fromARGB(164, 164, 164, 164),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 3,
                    ),
                    itemCount: colors.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          // Aktualizujemy zamówienie z wybranym kolorem
                          widget.order.color = colors[index].name;

                          // Przekierowujemy do następnej strony i przekazujemy zaktualizowane zamówienie
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  FrontSizePage(order: widget.order),
                              transitionDuration: Duration(seconds: 0),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(colors[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(colors[index].name),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
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
