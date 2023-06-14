import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/model.dart';
import 'package:flutter_2kbr/pages/fronts/front_color_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_color_page.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';

class SillModelPage extends StatefulWidget {
  @override
  _SillModelPageState createState() => _SillModelPageState();
}

class _SillModelPageState extends State<SillModelPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Model> models = [
      Model(name: "Ramiak", image: 'assets/fronty/ZOBA_04_238.jpg', modelId: 1),
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
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              child: Text(
                'Poniższe Sill meblowe są dostępne w różnorodnej kolorystyce',
                style: TextStyle(
                  color: Color.fromARGB(164, 164, 164, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: models.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Order order = Order(
                            model: models[index].name,
                            modelId: models[index].modelId,
                            colorId: 0,
                            mdfId: 0,
                            color: '',
                            mdf: '',
                            height: 0,
                            width: 0,
                            type: "sill");
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                SillColorPage(order: order),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(models[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            models[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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