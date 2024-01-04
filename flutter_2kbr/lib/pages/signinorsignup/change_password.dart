import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    String username = _usernameController.text;
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;

    try {
      await ApiService().changePassword(username, oldPassword, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change password')),
      );
    }
  }

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
                await navigateWithoutAnimation(context, HomePage());
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
                padding:
                    EdgeInsets.only(top: 10, left: 80, right: 80, bottom: 10),
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
                            'Zmień hasło',
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
                            controller: _oldPasswordController,
                            decoration:
                                InputDecoration(labelText: 'Stare hasło'),
                            obscureText: true,
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
                            controller: _newPasswordController,
                            decoration:
                                InputDecoration(labelText: 'Nowe hasło'),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _changePassword,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                      ),
                      child: Text(
                        'Zmień hasło',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        await navigateWithoutAnimation(context, LoginPage());
                      },
                      child: Text('Wróć do logowania',
                          style: TextStyle(fontSize: 15, color: Colors.orange)),
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
