import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/about_page.dart';
import 'package:flutter_2kbr/pages/admin/client_edit_page.dart';
import 'package:flutter_2kbr/pages/cart_page.dart';
import 'package:flutter_2kbr/pages/contact_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/pages/offer_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/fronts/front_model_page.dart';

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
      automaticallyImplyLeading: false,
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
                Expanded(
                    child: Image.asset('assets/images/logo.png', height: 60)),
                if (isAdmin)
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: () async => await navigateWithoutAnimation(
                        context, ClientEditPage()),
                  ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            CartPage(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  },
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
                )
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
                    'Strona główna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, OfferPage()),
                  child: Text(
                    'Oferta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, AboutPage()),
                  child: Text('O nas',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                ),
                TextButton(
                  onPressed: () async =>
                      await navigateWithoutAnimation(context, ContactPage()),
                  child: Text('Kontakt',
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
