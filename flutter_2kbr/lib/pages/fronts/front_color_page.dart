import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/color.dart';
import 'package:flutter_2kbr/pages/fronts/front_size.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class FrontColorPage extends StatefulWidget {
  final Order order;

  FrontColorPage({required this.order});

  @override
  _FrontColorPageState createState() => _FrontColorPageState();
}

class _FrontColorPageState extends State<FrontColorPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final List<ColorModel> colors = [
      ColorModel(name: "KREMOWY 02", image: 'assets/kolory/02.jpg', colorId: 2),
      ColorModel(
          name: "BRZOZA ROSA 05", image: 'assets/kolory/05.jpg', colorId: 5),
      ColorModel(name: "BIAŁY 10", image: 'assets/kolory/10.jpg', colorId: 10),
      ColorModel(
          name: "DĄB CZARNY", image: 'assets/kolory/33.jpg', colorId: 33),
      ColorModel(
          name: "FINO BRONZE 46", image: 'assets/kolory/46.jpg', colorId: 46),
      ColorModel(
          name: "ORZECH WŁOSKI 50", image: 'assets/kolory/50.jpg', colorId: 50),
      ColorModel(
          name: "ORZECH PERŁA 51", image: 'assets/kolory/51.jpg', colorId: 51),
      ColorModel(
          name: "ZEBRANO BEZ 74", image: 'assets/kolory/74.jpg', colorId: 74),
      ColorModel(name: "ŚLIWKA 76", image: 'assets/kolory/76.jpg', colorId: 76),
      ColorModel(
          name: "ZEBRANO BRĄZ 77", image: 'assets/kolory/77.jpg', colorId: 77),
      ColorModel(
          name: "KORA CZARNA 90", image: 'assets/kolory/90.jpg', colorId: 90),
      ColorModel(
          name: "SALOPE 101", image: 'assets/kolory/101.jpg', colorId: 101),
      ColorModel(
          name: "ANTIQUE 117", image: 'assets/kolory/117.jpg', colorId: 117),
      ColorModel(
          name: "CIEMNA WIŚNIA 193",
          image: 'assets/kolory/193.jpg',
          colorId: 193),
      ColorModel(
          name: "SHEFELD 208", image: 'assets/kolory/208.jpg', colorId: 208),
      ColorModel(
          name: "JAŚMIN 209", image: 'assets/kolory/209.jpg', colorId: 209),
      ColorModel(
          name: "CINNA WENGE 210",
          image: 'assets/kolory/210.jpg',
          colorId: 210),
      ColorModel(
          name: "ORZECH TABACO 214",
          image: 'assets/kolory/214.jpg',
          colorId: 214),
      ColorModel(
          name: "PRUGNA 215", image: 'assets/kolory/215.jpg', colorId: 215),
      ColorModel(
          name: "ORZECH WŁOSKI 218",
          image: 'assets/kolory/218.jpg',
          colorId: 218),
      ColorModel(
          name: "ZŁOTY DĄB 219", image: 'assets/kolory/219.jpg', colorId: 219),
      ColorModel(
          name: "DĄB BAGIENNY 221",
          image: 'assets/kolory/221.jpg',
          colorId: 221),
      ColorModel(
          name: "AVELLINO 222", image: 'assets/kolory/222.jpg', colorId: 222),
      ColorModel(
          name: "BIAŁA STRUKTURA 229",
          image: 'assets/kolory/229.jpg',
          colorId: 229),
      ColorModel(
          name: "BIAŁY MAT 237", image: 'assets/kolory/237.jpg', colorId: 237),
      ColorModel(
          name: "ACCIANO 243", image: 'assets/kolory/243.jpg', colorId: 243),
      ColorModel(
          name: "ROSSO 248", image: 'assets/kolory/248.jpg', colorId: 248),
      ColorModel(
          name: "SAN REMO 252", image: 'assets/kolory/252.jpg', colorId: 252),
      ColorModel(
          name: "RUSTIC 253", image: 'assets/kolory/253.jpg', colorId: 253),
      ColorModel(
          name: "AMBER OAK 254", image: 'assets/kolory/254.jpg', colorId: 254),
      ColorModel(
          name: "NUSSBAUM COLUMBIA 256",
          image: 'assets/kolory/256.jpg',
          colorId: 256),
      ColorModel(
          name: "PERLMUTT 258", image: 'assets/kolory/258.jpg', colorId: 258),
      ColorModel(
          name: "GREYMUTT 259", image: 'assets/kolory/259.jpg', colorId: 259),
      ColorModel(
          name: "ANTRACYT 260", image: 'assets/kolory/260.jpg', colorId: 260),
      ColorModel(
          name: "PINIO BIAŁA 261",
          image: 'assets/kolory/261.jpg',
          colorId: 261),
      ColorModel(
          name: "PINIO KREM 262", image: 'assets/kolory/262.jpg', colorId: 262),
      ColorModel(
          name: "PINIO SZARE 264",
          image: 'assets/kolory/264.jpg',
          colorId: 264),
      ColorModel(
          name: "SILVER 265", image: 'assets/kolory/265.jpg', colorId: 265),
      ColorModel(
          name: "BUK ICONIC 266", image: 'assets/kolory/266.jpg', colorId: 266),
      ColorModel(
          name: "LENGO 267", image: 'assets/kolory/267.jpg', colorId: 267),
      ColorModel(
          name: "SANGALLO 268", image: 'assets/kolory/268.jpg', colorId: 268),
      ColorModel(
          name: "ALABASTER 269", image: 'assets/kolory/269.jpg', colorId: 269),
      ColorModel(
          name: "STIRLING OAK 272",
          image: 'assets/kolory/272.jpg',
          colorId: 272),
      ColorModel(
          name: "POMARAŃCZOWY 275",
          image: 'assets/kolory/275.jpg',
          colorId: 275),
      ColorModel(
          name: "ANTRACYT SKÓRA 277",
          image: 'assets/kolory/277.jpg',
          colorId: 277),
      ColorModel(
          name: "AKACJA 278", image: 'assets/kolory/278.jpg', colorId: 278),
      ColorModel(
          name: "LIGHTGREY 282", image: 'assets/kolory/282.jpg', colorId: 282),
      ColorModel(
          name: "PORCELAIN WHITE 283",
          image: 'assets/kolory/283.jpg',
          colorId: 283),
      ColorModel(
          name: "OLMO ODEON 286", image: 'assets/kolory/286.jpg', colorId: 286),
      ColorModel(
          name: "FOGO HARBOUR 290",
          image: 'assets/kolory/290.jpg',
          colorId: 290),
      ColorModel(
          name: "FRESKO NEVADA 292",
          image: 'assets/kolory/292.jpg',
          colorId: 292),
      ColorModel(
          name: "HENDRIX BETON 293",
          image: 'assets/kolory/293.jpg',
          colorId: 293),
      ColorModel(
          name: "FRESKO COLORADO 294",
          image: 'assets/kolory/294.jpg',
          colorId: 294),
      ColorModel(
          name: "BIAŁA SUPERMAT 352",
          image: 'assets/kolory/352.jpg',
          colorId: 352),
      ColorModel(
          name: "ALABASTER SUPERMAT 353",
          image: 'assets/kolory/353.jpg',
          colorId: 353),
      ColorModel(
          name: "MUSEL SUPERMAT 354",
          image: 'assets/kolory/354.jpg',
          colorId: 354),
      ColorModel(
          name: "AUBERGINE SUPERMAT 355",
          image: 'assets/kolory/355.jpg',
          colorId: 355),
      ColorModel(
          name: "STONE GREY SUPERMAT 357",
          image: 'assets/kolory/357.jpg',
          colorId: 357),
      ColorModel(
          name: "PISTACHIO SUPERMAT 359",
          image: 'assets/kolory/359.jpg',
          colorId: 359),
      ColorModel(
          name: "PORTUNA 408", image: 'assets/kolory/408.jpg', colorId: 408),
      ColorModel(
          name: "TEAK 410", image: 'assets/kolory/410.jpg', colorId: 410),
      ColorModel(
          name: "KLON CIEMNY 426",
          image: 'assets/kolory/426.jpg',
          colorId: 426),
      ColorModel(
          name: "TROJAN 428", image: 'assets/kolory/428.jpg', colorId: 428),
      ColorModel(
          name: "KASZTAN 462", image: 'assets/kolory/462.jpg', colorId: 462),
      ColorModel(
          name: "MODRZEW 464", image: 'assets/kolory/464.jpg', colorId: 464),
      ColorModel(name: "470", image: 'assets/kolory/470.jpg', colorId: 470),
    ];

    var size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width > 800 ? size.width * 0.2 : 0.9;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () => authProvider.isLoggedIn
              ? authProvider.logout()
              : _navigateToLogin(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              child: Text(
                'Wybierz kolor frontów meblowych',
                style: TextStyle(
                  color: Color.fromARGB(164, 164, 164, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 3,
                  ),
                  itemCount: colors.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        final updatedOrder = widget.order.copyWith(
                            color: colors[index].name,
                            colorId: colors[index].colorId);
                        print(jsonEncode(updatedOrder.toJson()));
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FrontSizePage(order: updatedOrder),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return child; // This disables the transition
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(colors[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          colors[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
