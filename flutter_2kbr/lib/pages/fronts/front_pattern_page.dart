import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/pattern.dart';
import 'package:flutter_2kbr/pages/fronts/front_color_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';

class FrontPatternPage extends StatefulWidget {
  @override
  _FrontPatternPageState createState() => _FrontPatternPageState();
}

class _FrontPatternPageState extends State<FrontPatternPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Wzor> patterns = [
      Wzor(name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg'),
      Wzor(name: "ANDROS 35", image: 'assets/fronty/ANDROS_035.jpg'),
      Wzor(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg'),
      Wzor(name: "BARI", image: 'assets/fronty/BARI_56.jpg'),
      Wzor(name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg'),
      Wzor(name: "ANDROS 35", image: 'assets/fronty/ANDROS_035.jpg'),
      Wzor(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg'),
      Wzor(name: "BARI", image: 'assets/fronty/BARI_56.jpg'),
      Wzor(name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg'),
      Wzor(name: "ANDROS 35", image: 'assets/fronty/ANDROS_035.jpg'),
      Wzor(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg'),
      Wzor(name: "BARI", image: 'assets/fronty/BARI_56.jpg'),
      Wzor(name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg'),
      Wzor(name: "ANDROS 35", image: 'assets/fronty/ANDROS_035.jpg'),
      Wzor(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg'),
      Wzor(name: "BARI", image: 'assets/fronty/BARI_56.jpg'),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () => authProvider.isLoggedIn
              ? authProvider.logout()
              : _navigateToLogin(),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: patterns.length,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  Order order = Order(
                    pattern: patterns[index].name,
                    color: '',
                    thickness: 2, // setting a valid initial thickness
                    height: 0,
                    width: 0,
                  );
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          FrontColorPage(order: order),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(patterns[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      patterns[index].name,
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
