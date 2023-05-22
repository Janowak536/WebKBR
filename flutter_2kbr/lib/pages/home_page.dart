import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/pages/weather_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart'; // Import CustomAppBar
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';

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
          onActionPressed: () => authProvider.isLoggedIn
              ? authProvider.logout()
              : _navigateToLogin(),
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
                  : const Text('Please log in to fetch weather forecast'),
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
        )).then((_) {
      setState(() {});
    });
  }
}
