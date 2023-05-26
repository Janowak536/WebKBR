import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/dtos/user_register_dto.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _clientIdController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nipController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _clientTypeController = TextEditingController();
  TextEditingController _discountCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: ListView(
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
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _nipController,
                decoration: InputDecoration(labelText: 'NIP'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'phone'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'address'),
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'city'),
              ),
              TextField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'postalCode'),
              ),
              TextField(
                controller: _clientTypeController,
                decoration: InputDecoration(labelText: 'clientType'),
              ),
              TextField(
                controller: _discountCodeController,
                decoration: InputDecoration(labelText: 'discount Code'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    UserRegisterDto dto = UserRegisterDto(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        clientId: int.tryParse(_clientIdController.text) ?? 0,
                        name: _nameController.text,
                        nip: _nipController.text,
                        phone: _phoneController.text,
                        email: _emailController.text,
                        address: _addressController.text,
                        city: _cityController.text,
                        postalCode: _postalCodeController.text);
                    try {
                      await ApiService().register(dto);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registered successfully')),
                      );
                      navigateWithoutAnimation(context, LoginPage());
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to register')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                },
                child: const Text('Register'),
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
    );
  }
}
