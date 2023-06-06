import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/pages/weather_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart'; // Import CustomAppBar
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/pages/fronty_page.dart';
import 'package:flutter_2kbr/pages/parapety_page.dart';

class FrontyPage extends StatefulWidget {
  @override
  _FrontyPageState createState() => _FrontyPageState();
}

class _FrontyPageState extends State<FrontyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

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
                  'Poniższe fronty meblowe są dostępne w różnorodnej kolorystyce',
                  style: TextStyle(
                    color: Color.fromARGB(164, 164, 164, 164),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 3,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[100],
                      child: const Text("He'd have you all unravel at the"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[200],
                      child: const Text('Heed not the rabble'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[300],
                      child: const Text('Sound of screams but the'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[400],
                      child: const Text('Who scream'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[500],
                      child: const Text('Revolution is coming...'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.teal[600],
                      child: const Text('Revolution, they...'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));

    /*
          Center(
              child: Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                  'Poniższe fronty meblowe dostępne są w różnej kolorystyce',
                  style: TextStyle(
                      color: Color.fromARGB(164, 164, 165, 164), fontSize: 30)),
            ),
          )
          ),
          ));*/
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
