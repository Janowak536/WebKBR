import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/services/api_service.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class ClientEditPage extends StatefulWidget {
  @override
  _ClientEditPageState createState() => _ClientEditPageState();
}

class _ClientEditPageState extends State<ClientEditPage> {
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _clientTypeController = TextEditingController();
  final TextEditingController _discountCodeController = TextEditingController();

  final ApiService apiClient = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _nipController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'NIP',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _clientTypeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Typ klienta',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _discountCodeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Kod rabatowy',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print('NIP: ${_nipController.text}');
                  print('Typ klienta: ${_clientTypeController.text}');
                  print('Kod rabatowy: ${_discountCodeController.text}');
                  try {
                    await apiClient.editClientDetails(
                        int.parse(_nipController.text),
                        _clientTypeController.text,
                        _discountCodeController.text);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Szczegóły klienta zostały zaktualizowane.')));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Nie udało się zaktualizować szczegółów klienta: $e')));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  'Zatwierdź',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
