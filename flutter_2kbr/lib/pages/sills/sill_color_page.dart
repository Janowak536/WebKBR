import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/color.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/pages/sills/sill_size.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class SillColorPage extends StatefulWidget {
  final Order order;

  SillColorPage({required this.order});

  @override
  _SillColorPageState createState() => _SillColorPageState();
}

class _SillColorPageState extends State<SillColorPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final List<ColorModel> colors = [
      ColorModel(name: "KREMOWY 02", image: 'assets/kolory/02.jpg'),
      ColorModel(name: "BRZOZA ROSA 05", image: 'assets/kolory/05.jpg'),
      ColorModel(name: "BIAŁY 10", image: 'assets/kolory/10.jpg'),
      ColorModel(name: "DĄB CZARNY", image: 'assets/kolory/33.jpg'),
      ColorModel(name: "FINO BRONZE 46", image: 'assets/kolory/46.jpg'),
      ColorModel(name: "ORZECH WŁOSKI 50", image: 'assets/kolory/50.jpg'),
      ColorModel(name: "ORZECH PERŁA 51", image: 'assets/kolory/51.jpg'),
      ColorModel(name: "ZEBRANO BEZ 74", image: 'assets/kolory/74.jpg'),
      ColorModel(name: "ŚLIWKA 76", image: 'assets/kolory/76.jpg'),
      ColorModel(name: "ZEBRANO BRĄZ 77", image: 'assets/kolory/77.jpg'),
      ColorModel(name: "KORA CZARNA 90", image: 'assets/kolory/90.jpg'),
      ColorModel(name: "SALOPE 101", image: 'assets/kolory/101.jpg'),
      ColorModel(name: "ANTIQUE 117", image: 'assets/kolory/117.jpg'),
      ColorModel(name: "CIEMNA WIŚNIA 193", image: 'assets/kolory/193.jpg'),
      ColorModel(name: "SHEFELD 208", image: 'assets/kolory/208.jpg'),
      ColorModel(name: "JAŚMIN 209", image: 'assets/kolory/209.jpg'),
      ColorModel(name: "CINNA WENGE 210", image: 'assets/kolory/210.jpg'),
      ColorModel(name: "ORZECH TABACO 214", image: 'assets/kolory/214.jpg'),
      ColorModel(name: "PRUGNA 215", image: 'assets/kolory/215.jpg'),
      ColorModel(name: "ORZECH WŁOSKI 218", image: 'assets/kolory/218.jpg'),
      ColorModel(name: "ZŁOTY DĄB 219", image: 'assets/kolory/219.jpg'),
      ColorModel(name: "DĄB BAGIENNY 221", image: 'assets/kolory/221.jpg'),
      ColorModel(name: "AVELLINO 222", image: 'assets/kolory/222.jpg'),
      ColorModel(name: "BIAŁA STRUKTURA 229", image: 'assets/kolory/229.jpg'),
      ColorModel(name: "BIAŁY MAT 237", image: 'assets/kolory/237.jpg'),
      ColorModel(name: "ACCIANO 243", image: 'assets/kolory/243.jpg'),
      ColorModel(name: "ROSSO 248", image: 'assets/kolory/248.jpg'),
      ColorModel(name: "SAN REMO 252", image: 'assets/kolory/252.jpg'),
      ColorModel(name: "RUSTIC 253", image: 'assets/kolory/253.jpg'),
      ColorModel(name: "AMBER OAK 254", image: 'assets/kolory/254.jpg'),
      ColorModel(name: "NUSSBAUM COLUMBIA 256", image: 'assets/kolory/256.jpg'),
      ColorModel(name: "PERLMUTT 258", image: 'assets/kolory/258.jpg'),
      ColorModel(name: "GREYMUTT 259", image: 'assets/kolory/259.jpg'),
      ColorModel(name: "ANTRACYT 260", image: 'assets/kolory/260.jpg'),
      ColorModel(name: "PINIO BIAŁA 261", image: 'assets/kolory/261.jpg'),
      ColorModel(name: "PINIO KREM 262", image: 'assets/kolory/262.jpg'),
      ColorModel(name: "PINIO SZARE 264", image: 'assets/kolory/264.jpg'),
      ColorModel(name: "SILVER 265", image: 'assets/kolory/265.jpg'),
      ColorModel(name: "BUK ICONIC 266", image: 'assets/kolory/266.jpg'),
      ColorModel(name: "LENGO 267", image: 'assets/kolory/267.jpg'),
      ColorModel(name: "SANGALLO 268", image: 'assets/kolory/268.jpg'),
      ColorModel(name: "ALABASTER 269", image: 'assets/kolory/269.jpg'),
      ColorModel(name: "STIRLING OAK 272", image: 'assets/kolory/272.jpg'),
      ColorModel(name: "POMARAŃCZOWY 275", image: 'assets/kolory/275.jpg'),
      ColorModel(name: "ANTRACYT SKÓRA 277", image: 'assets/kolory/277.jpg'),
      ColorModel(name: "AKACJA 278", image: 'assets/kolory/278.jpg'),
      ColorModel(name: "LIGHTGREY 282", image: 'assets/kolory/282.jpg'),
      ColorModel(name: "PORCELAIN WHITE 283", image: 'assets/kolory/283.jpg'),
      ColorModel(name: "OLMO ODEON 286", image: 'assets/kolory/286.jpg'),
      ColorModel(name: "FOGO HARBOUR 290", image: 'assets/kolory/290.jpg'),
      ColorModel(name: "FRESKO NEVADA 292", image: 'assets/kolory/292.jpg'),
      ColorModel(name: "HENDRIX BETON 293", image: 'assets/kolory/293.jpg'),
      ColorModel(name: "FRESKO COLORADO 294", image: 'assets/kolory/294.jpg'),
      ColorModel(name: "BIAŁA SUPERMAT 352", image: 'assets/kolory/352.jpg'),
      ColorModel(
          name: "ALABASTER SUPERMAT 353", image: 'assets/kolory/353.jpg'),
      ColorModel(name: "MUSEL SUPERMAT 354", image: 'assets/kolory/354.jpg'),
      ColorModel(
          name: "AUBERGINE SUPERMAT 355", image: 'assets/kolory/355.jpg'),
      ColorModel(
          name: "STONE GREY SUPERMAT 357", image: 'assets/kolory/357.jpg'),
      ColorModel(
          name: "PISTACHIO SUPERMAT 359", image: 'assets/kolory/359.jpg'),
      ColorModel(name: "PORTUNA 408", image: 'assets/kolory/408.jpg'),
      ColorModel(name: "TEAK 410", image: 'assets/kolory/410.jpg'),
      ColorModel(name: "KLON CIEMNY 426", image: 'assets/kolory/426.jpg'),
      ColorModel(name: "TROJAN 428", image: 'assets/kolory/428.jpg'),
      ColorModel(name: "KASZTAN 462", image: 'assets/kolory/462.jpg'),
      ColorModel(name: "MODRZEW 464", image: 'assets/kolory/464.jpg'),
      ColorModel(name: "470", image: 'assets/kolory/470.jpg'),
      // Add more colors
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
                'Wybierz kolor parapetów',
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
                        final updatedOrder =
                            widget.order.copyWith(color: colors[index].name);
                        Navigator.of(context).pushReplacement(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    SillSizePage(order: updatedOrder),
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
