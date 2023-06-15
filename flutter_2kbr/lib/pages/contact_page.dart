import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:flutter_2kbr/widgets/get_map_widget.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/contact.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30,
                            top: MediaQuery.of(context).size.height / 20,
                            child: Text(
                              'Kontakt',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text("user1"),
                              Text("ul.długa 32"),
                              Text("123-123-123"),
                              Text("33-333 Gdańsk"),
                              Text("18 232 33 32"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text("user1"),
                              Text("ul.długa 32"),
                              Text("123-123-123"),
                              Text("33-333 Gdańsk"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text("user1"),
                              Text("ul.długa 32"),
                              Text("123-123-123"),
                              Text("33-333 Gdańsk"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: Column(
                        children: [
                          Icon(Icons.person),
                          Column(
                            children: [
                              Text("user1"),
                              Text("ul.długa 32"),
                              Text("123-123-123"),
                              Text("33-333 Gdańsk"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: getMap(),
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
      ),
    ).then((_) {
      setState(() {});
    });
  }
}
