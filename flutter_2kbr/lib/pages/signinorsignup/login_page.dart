import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/signinorsignup/change_password.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/register_page.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: 20,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage(),
                    transitionDuration: Duration(seconds: 0),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                  (route) => false,
                );
              },
              child: Image.asset('assets/images/logo.png',
                  width: 200, height: 200),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade300,
                ),
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.all(100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(bottom: 40),
                          child: Text(
                            'Zaloguj',
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(labelText: 'Login'),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Hasło'),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          String jwt = await ApiService().login(
                            _usernameController.text,
                            _passwordController.text,
                          );
                          bool isAdmin = await ApiService().isAdmin();
                          Provider.of<AuthProvider>(context, listen: false)
                              .isAdmin = isAdmin;
                          Provider.of<AuthProvider>(context, listen: false)
                              .toggleLoginStatus();
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Zostałeś zalogowany')),
                          );
                          await navigateWithoutAnimation(context, HomePage());
                        } catch (e) {
                          if (!mounted) return;
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Błąd podczas logowania')),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                      ),
                      child: Text(
                        'Zaloguj',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        await navigateWithoutAnimation(context, RegisterPage());
                      },
                      child: Text(
                        'Zarejestruj się',
                        style: TextStyle(fontSize: 15, color: Colors.orange),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        await navigateWithoutAnimation(
                            context, ChangePasswordPage());
                      },
                      child: Text(
                        'Zmień hasło',
                        style: TextStyle(fontSize: 15, color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
