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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () {
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            if (authProvider.isLoggedIn) {
              authProvider.logout();
            }
          },
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              authProvider.isLoggedIn
                  ? ElevatedButton(
                      onPressed: () {
                        navigateWithoutAnimation(context, WeatherPage());
                      },
                      child: const Text('Fetch Weather Forecast'),
                    )
                  // Remove spacing between the button and tiles
                  : TextButton(
                      onPressed: () async =>
                          await navigateWithoutAnimation(context, FrontyPage()),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/fronty_header.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 250,
                        child: Center(
                          child: Text(
                            'Fronty',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 50), // Spacing between the tiles
              TextButton(
                onPressed: () async =>
                    await navigateWithoutAnimation(context, ParapetyPage()),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/parapety_header2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 250,
                  child: Center(
                    child: Text(
                      'Parapety',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 20,
                      ),
                    ),
                  ),
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
}
