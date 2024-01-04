import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/pages/offer_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_model_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_size.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:flutter_2kbr/widgets/navigate_animation.dart';
import 'package:provider/provider.dart';
import '../widgets/footer_bar.dart';
import 'fronts/front_model_page.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    var size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width > 800 ? size.width * 0.2 : 0.9;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: CustomAppBar(
            onActionPressed: () {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              if (authProvider.isLoggedIn) {
                authProvider.logout();
              }
            },
          ),
          body: SingleChildScrollView(
              child: Center(
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/klasyczna.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 350,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 15),
                    child: Text(
                      'O nas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    top: MediaQuery.of(context).size.height / 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),
                            Text(
                              'Szanowni Państwo',
                              style: TextStyle(
                                color: Color.fromARGB(164, 164, 164, 164),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Wychodząc naprzeciw trendom i wymaganiom jakie stawia rynek, postanowiliśmy stworzyć nową markę 2KBR, opartą na ponad 15-letnim doświadczeniu w produkcji frontów meblowych i parapetów. Podążając tą drogą stworzyliśmy dla Państwa ofertę opartą na płycie o podwyższonej gęstości z dużym wyborem dostępnych frezowań, dodatkowo poszerzonym o możliwość modyfikacji. Bogata kolorystyka folii natomiast daje gwarancję uzyskania niepowtarzalnej konfiguracji kuchni. Wyjątkowa oferta handlowa, nowoczesne wzornictwo i wysoka jakość produktu powstaje dzięki zastosowaniu najlepszych materiałów, nowych technologii przyjaznych dla środowiska jak i zaangażowaniu naszych klientów.',
                              style: TextStyle(
                                color: Color.fromARGB(164, 164, 164, 164),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo2.jpg'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Footer()
            ]),
          )),
        ));
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
