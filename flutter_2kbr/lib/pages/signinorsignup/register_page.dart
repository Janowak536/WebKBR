import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/dtos/user_register_dto.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nipController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();

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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade300,
              ),
              padding: EdgeInsets.all(40),
              height:
                  MediaQuery.of(context).size.height * 0.8, // Updated height
              width: MediaQuery.of(context).size.width * 0.6,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _buildFormColumn(
                                [
                                  _usernameController,
                                  _passwordController,
                                  _confirmPasswordController,
                                  _nameController,
                                  _nipController,
                                ],
                                [
                                  'Username',
                                  'Password',
                                  'Confirm Password',
                                  'Name',
                                  'NIP'
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: _buildFormColumn(
                                [
                                  _emailController,
                                  _phoneController,
                                  _addressController,
                                  _cityController,
                                  _postalCodeController,
                                ],
                                [
                                  'Email',
                                  'Phone',
                                  'Address',
                                  'City',
                                  'Postal Code'
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _performLogin,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                      ),
                      child: Text(
                        'Zarejestruj',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        navigateWithoutAnimation(context, LoginPage());
                      },
                      child: const Text('Sign In'),
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

  Column _buildFormColumn(
      List<TextEditingController> controllers, List<String> labels) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(controllers.length, (index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10.0),
          child: TextField(
            controller: controllers[index],
            decoration: InputDecoration(
              labelText: labels[index],
              border: UnderlineInputBorder(),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _performLogin() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      UserRegisterDto newUser = UserRegisterDto(
        username: _usernameController.text,
        password: _passwordController.text,
        name: _nameController.text,
        nip: _nipController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text,
      );
      print(jsonEncode(newUser.toJson()));
      await ApiService().register(newUser);

      String jwt = await ApiService().login(
        _usernameController.text,
        _passwordController.text,
      );

      bool isAdmin = await ApiService().isAdmin();

      Provider.of<AuthProvider>(context, listen: false).isAdmin = isAdmin;
      Provider.of<AuthProvider>(context, listen: false).toggleLoginStatus();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration and login successfully')),
      );

      await navigateWithoutAnimation(context, HomePage());
    } catch (e) {
      if (!mounted) return;

      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to Register/Login')),
      );
    }
  }
}
