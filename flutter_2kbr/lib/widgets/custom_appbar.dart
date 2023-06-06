import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/client_edit_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/weather_page.dart';
import 'package:flutter_2kbr/pages/fronty_page.dart';
import 'package:flutter_2kbr/pages/parapety_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onActionPressed;

  CustomAppBar({
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    bool isAdmin = Provider.of<AuthProvider>(context).isAdmin;
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 8),
                Expanded(child: Image.asset('assets/logo.png', height: 60)),
                if (isAdmin)
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: () async => await navigateWithoutAnimation(
                        context, ClientEditPage()),
                  ),
                IconButton(
                  onPressed: () {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    if (authProvider.isLoggedIn) {
                      authProvider.logout();
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              HomePage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    } else {
                      _navigateToLogin(context);
                    }
                  },
                  icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
                  color: Colors.white,
                  iconSize: 35,
                  tooltip: isLoggedIn ? 'Logout' : 'Login',
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, HomePage()),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final isLoggedIn = context.read<AuthProvider>().isLoggedIn;
                    if (isLoggedIn) {
                      await navigateWithoutAnimation(context, WeatherPage());
                    } else {
                      await navigateWithoutAnimation(context, LoginPage());
                    }
                  },
                  child: Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, FrontyPage()),
                  child: Text('Fronty',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                ),
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, ParapetyPage()),
                  child: Text('Parapety',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 2.6);
}
