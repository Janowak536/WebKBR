import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/pattern.dart';
import 'package:flutter_2kbr/pages/fronts/front_color_page.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';

class FrontPatternPage extends StatefulWidget {
  @override
  _FrontPatternPageState createState() => _FrontPatternPageState();
}

class _FrontPatternPageState extends State<FrontPatternPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Wzor> patterns = [
      Wzor(name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg'),
      Wzor(name: "ANDROS", image: 'assets/fronty/ANDROS_035.jpg'),
      Wzor(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg'),
      Wzor(name: "BARI", image: 'assets/fronty/BARI_56.jpg'),
      Wzor(name: "BBO 04", image: 'assets/fronty/BBO_004.jpg'),
      Wzor(name: "BBO 05", image: 'assets/fronty/BBO_05.jpg'),
      Wzor(name: "BOSTON", image: 'assets/fronty/BOSTON_51.jpg'),
      Wzor(name: "BREVE", image: 'assets/fronty/BREVE_238.jpg'),
      Wzor(name: "CASA", image: 'assets/fronty/CASA_002.jpg'),
      Wzor(name: "CBO", image: 'assets/fronty/CBO_11.jpg'),
      Wzor(name: "DELOS", image: 'assets/fronty/DELOS_290.jpg'),
      Wzor(name: "DEVON", image: 'assets/fronty/DEVON_076.jpg'),
      Wzor(name: "EBO", image: 'assets/fronty/EBO_28.jpg'),
      Wzor(name: "FGO", image: 'assets/fronty/FGO_33.jpg'),
      Wzor(name: "FOLKI", image: 'assets/fronty/FOLKI_354.jpg'),
      Wzor(name: "GGO", image: 'assets/fronty/GGO_012.jpg'),
      Wzor(name: "GRIFF", image: 'assets/fronty/GRIFF_000.jpg'),
      Wzor(name: "HGO", image: 'assets/fronty/HGO_50.jpg'),
      Wzor(name: "IGO", image: 'assets/fronty/IGO_215.jpg'),
      Wzor(name: "JGO", image: 'assets/fronty/JGO_219.jpg'),
      Wzor(name: "KANNA", image: 'assets/fronty/KANNA_214.jpg'),
      Wzor(name: "KANTRY", image: 'assets/fronty/KANTRY_261.jpg'),
      Wzor(name: "KARBO", image: 'assets/fronty/KARBO_254.jpg'),
      Wzor(name: "KBZ", image: 'assets/fronty/KBZ_272.jpg'),
      Wzor(name: "KLASYK", image: 'assets/fronty/KLASYK_263.jpg'),
      Wzor(name: "KWADRO", image: 'assets/fronty/KWADRO_416.jpg'),
      Wzor(name: "LAME", image: 'assets/fronty/LAME_362.jpg'),
      Wzor(name: "LBO", image: 'assets/fronty/LBO_229.jpg'),
      Wzor(name: "LINDOS", image: 'assets/fronty/LINDOS_237.jpg'),
      Wzor(name: "LONDON", image: 'assets/fronty/LONDON_251.jpg'),
      Wzor(name: "LUROSA", image: 'assets/fronty/LUROSA_260.jpg'),
      Wzor(name: "MADERA", image: 'assets/fronty/MADERA_262.jpg'),
      Wzor(name: "MALAGA 2", image: 'assets/fronty/MALAGA_2_355.jpg'),
      Wzor(name: "MALAGA", image: 'assets/fronty/MALAGA_264.jpg'),
      Wzor(name: "MARCO", image: 'assets/fronty/MARCO_410.jpg'),
      Wzor(name: "MGO", image: 'assets/fronty/MGO_360.jpg'),
      Wzor(name: "MILOS", image: 'assets/fronty/MILOS_273.jpg'),
      Wzor(name: "MODENA", image: 'assets/fronty/MODENA_282.jpg'),
      Wzor(name: "MOIRA", image: 'assets/fronty/MOIRA_286.jpg'),
      Wzor(name: "MONA", image: 'assets/fronty/MONA_255.jpg'),
      Wzor(name: "MONTY", image: 'assets/fronty/MONTY_289.jpg'),
      Wzor(name: "NEAPOL", image: 'assets/fronty/NEAPOL_221.jpg'),
      Wzor(name: "NGO", image: 'assets/fronty/NGO_210.jpg'),
      Wzor(name: "NO_NAME2", image: 'assets/fronty/NO_NAME_2-1.jpg'),
      Wzor(name: "NO_NAME3", image: 'assets/fronty/NO_NAME3.jpg'),
      Wzor(name: "OIO", image: 'assets/fronty/OIO_90.jpg'),
      Wzor(name: "PALOMA", image: 'assets/fronty/PALOMA_218.jpg'),
      Wzor(name: "PARMA", image: 'assets/fronty/PARMA_353.jpg'),
      Wzor(name: "PAROS", image: 'assets/fronty/PAROS_283.jpg'),
      Wzor(name: "PATI", image: 'assets/fronty/PATI_256.jpg'),
      Wzor(name: "PIANTA", image: 'assets/fronty/PIANTA_362.jpg'),
      Wzor(name: "PILLOS", image: 'assets/fronty/PILLOS_292.jpg'),
      Wzor(name: "PILLOW", image: 'assets/fronty/PILLOW_253.jpg'),
      Wzor(name: "PORTYK", image: 'assets/fronty/PORTYK_428.jpg'),
      Wzor(name: "PRADA", image: 'assets/fronty/PRADA_462.jpg'),
      Wzor(name: "QGO", image: 'assets/fronty/QGO_278.jpg'),
      Wzor(name: "RAMIAK", image: 'assets/fronty/RAMIAK_470.jpg'),
      Wzor(name: "RAMKO", image: 'assets/fronty/RAMKO_222.jpg'),
      Wzor(name: "RAMONA", image: 'assets/fronty/RAMONA_252.jpg'),
      Wzor(name: "RAMPEL 60", image: 'assets/fronty/RAMPEL_60_209.jpg'),
      Wzor(name: "RAMPEL 360", image: 'assets/fronty/RAMPEL_360.jpg'),
      Wzor(name: "RAPINO", image: 'assets/fronty/RAPINO_357.jpg'),
      Wzor(name: "RAVENA", image: 'assets/fronty/RAVENA_210.jpg'),
      Wzor(name: "RAWA", image: 'assets/fronty/RAWA_284.jpg'),
      Wzor(name: "RBO", image: 'assets/fronty/RBO_105.jpg'),
      Wzor(name: "RENA", image: 'assets/fronty/RENA_359.jpg'),
      Wzor(name: "ROMA", image: 'assets/fronty/ROMA_104.jpg'),
      Wzor(name: "ROXANA", image: 'assets/fronty/ROXANA_238.jpg'),
      Wzor(name: "SANDRA", image: 'assets/fronty/SANDRA_286.jpg'),
      Wzor(name: "SEVERO", image: 'assets/fronty/SEVERO_362.jpg'),
      Wzor(name: "SIO", image: 'assets/fronty/SIO_408.jpg'),
      Wzor(name: "SPRINT", image: 'assets/fronty/SPRINT_002.jpg'),
      Wzor(name: "STRIPE", image: 'assets/fronty/STRIPE_243.jpg'),
      Wzor(name: "TAMARA", image: 'assets/fronty/TAMARA_280.jpg'),
      Wzor(name: "TELAIO", image: 'assets/fronty/TELAIO_407.jpg'),
      Wzor(name: "TEXAS", image: 'assets/fronty/TEXAS_238.jpg'),
      Wzor(name: "TGO", image: 'assets/fronty/TGO_209.jpg'),
      Wzor(name: "TORINO", image: 'assets/fronty/TORINO_257.jpg'),
      Wzor(name: "UGO", image: 'assets/fronty/UGO_258.jpg'),
      Wzor(name: "VARIO", image: 'assets/fronty/VARIO_lakier.jpg'),
      Wzor(name: "VEGA", image: 'assets/fronty/VEGA_267.jpg'),
      Wzor(name: "VERONA", image: 'assets/fronty/VERONA_259.jpg'),
      Wzor(name: "VIO", image: 'assets/fronty/VIO_417.jpg'),
      Wzor(name: "WAZA", image: 'assets/fronty/WAZA_35.jpg'),
      Wzor(name: "WDO", image: 'assets/fronty/WDO_287.jpg'),
      Wzor(name: "WENECJA", image: 'assets/fronty/WENECJA_464.jpg'),
      Wzor(name: "WIKI", image: 'assets/fronty/WIKI_238.jpg'),
      Wzor(name: "XDO", image: 'assets/fronty/XDO_424.jpg'),
      Wzor(name: "YDO", image: 'assets/fronty/YDO_250.jpg'),
      Wzor(name: "ZGO", image: 'assets/fronty/ZGO_46.jpg'),
      Wzor(name: "ZOBA", image: 'assets/fronty/ZOBA_04_238.jpg'),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          onActionPressed: () => authProvider.isLoggedIn
              ? authProvider.logout()
              : _navigateToLogin(),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(10),
              child: Text(
                'Poniższe fronty meblowe są dostępne w różnorodnej kolorystyce',
                style: TextStyle(
                  color: Color.fromARGB(164, 164, 164, 164),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: patterns.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Order order = Order(
                          pattern: patterns[index].name,
                          color: '',
                          thickness: 2, // setting a valid initial thickness
                          height: 0,
                          width: 0,
                        );
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                FrontColorPage(order: order),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(patterns[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            patterns[index].name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
