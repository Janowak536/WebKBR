import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class ClientEditPage extends StatefulWidget {
  @override
  _ClientEditPageState createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage> {
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _clientTypeController = TextEditingController();
  final TextEditingController _discountCodeController = TextEditingController();

  final ApiService apiClient = ApiService(); // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionPressed: () {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          if (authProvider.isLoggedIn) {
            authProvider.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            _navigateToLogin();
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _clientIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Client Id',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _clientTypeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Client Type',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _discountCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Discount Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement your logic to edit client details
                print('Client Id: ${_clientIdController.text}');
                print('Client Type: ${_clientTypeController.text}');
                print('Discount Code: ${_discountCodeController.text}');

                // Add these lines
                try {
                  await apiClient.editClientDetails(
                      int.parse(_clientIdController.text),
                      _clientTypeController.text,
                      _discountCodeController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Client details edited successfully')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to edit client details: $e')));
                }
              },
              child: Text('Submit'),
            ),
          ],
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
