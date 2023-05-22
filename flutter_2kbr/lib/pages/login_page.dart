import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/register_page.dart';
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
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ApiService().login(
                      _usernameController.text,
                      _passwordController.text,
                    );
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login successfully')),
                    );
                    Provider.of<AuthProvider>(context, listen: false)
                        .checkLoginStatus();
                    await navigateWithoutAnimation(context, HomePage());
                  } catch (e) {
                    if (!mounted) return;
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to Login')),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  await Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                    (route) => false,
                  );
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
