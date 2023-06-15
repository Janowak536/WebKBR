import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:flutter_2kbr/data/models/model.dart';
import 'package:flutter_2kbr/pages/fronts/front_color_page.dart';
import 'package:flutter_2kbr/pages/signinorsignup/login_page.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';

class FrontModelPage extends StatefulWidget {
  @override
  _FrontModelPageState createState() => _FrontModelPageState();
}

class _FrontModelPageState extends State<FrontModelPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final List<Model> models = [
      Model(
          name: "3D Lakier", image: 'assets/fronty/3D_Lakier.jpg', modelId: 6),
      Model(name: "ANDROS", image: 'assets/fronty/ANDROS_035.jpg', modelId: 7),
      Model(name: "ANSE", image: 'assets/fronty/ANSE_238.jpg', modelId: 8),
      Model(name: "BARI", image: 'assets/fronty/BARI_56.jpg', modelId: 9),
      Model(name: "BBO 04", image: 'assets/fronty/BBO_004.jpg', modelId: 10),
      Model(name: "BBO 05", image: 'assets/fronty/BBO_05.jpg', modelId: 11),
      Model(name: "BOSTON", image: 'assets/fronty/BOSTON_51.jpg', modelId: 12),
      Model(name: "BREVE", image: 'assets/fronty/BREVE_238.jpg', modelId: 13),
      Model(name: "CASA", image: 'assets/fronty/CASA_002.jpg', modelId: 14),
      Model(name: "CBO", image: 'assets/fronty/CBO_11.jpg', modelId: 15),
      Model(name: "DELOS", image: 'assets/fronty/DELOS_290.jpg', modelId: 16),
      Model(name: "DEVON", image: 'assets/fronty/DEVON_076.jpg', modelId: 17),
      Model(name: "EBO", image: 'assets/fronty/EBO_28.jpg', modelId: 18),
      Model(name: "FGO", image: 'assets/fronty/FGO_33.jpg', modelId: 19),
      Model(name: "FOLKI", image: 'assets/fronty/FOLKI_354.jpg', modelId: 20),
      Model(name: "GGO", image: 'assets/fronty/GGO_012.jpg', modelId: 21),
      Model(name: "GRIFF", image: 'assets/fronty/GRIFF_000.jpg', modelId: 22),
      Model(name: "HGO", image: 'assets/fronty/HGO_50.jpg', modelId: 23),
      Model(name: "IGO", image: 'assets/fronty/IGO_215.jpg', modelId: 24),
      Model(name: "JGO", image: 'assets/fronty/JGO_219.jpg', modelId: 25),
      Model(name: "KANNA", image: 'assets/fronty/KANNA_214.jpg', modelId: 26),
      Model(name: "KANTRY", image: 'assets/fronty/KANTRY_261.jpg', modelId: 27),
      Model(name: "KARBO", image: 'assets/fronty/KARBO_254.jpg', modelId: 28),
      Model(name: "KBZ", image: 'assets/fronty/KBZ_272.jpg', modelId: 29),
      Model(name: "KLASYK", image: 'assets/fronty/KLASYK_263.jpg', modelId: 30),
      Model(name: "KWADRO", image: 'assets/fronty/KWADRO_416.jpg', modelId: 31),
      Model(name: "LAME", image: 'assets/fronty/LAME_362.jpg', modelId: 32),
      Model(name: "LBO", image: 'assets/fronty/LBO_229.jpg', modelId: 33),
      Model(name: "LINDOS", image: 'assets/fronty/LINDOS_237.jpg', modelId: 34),
      Model(name: "LONDON", image: 'assets/fronty/LONDON_251.jpg', modelId: 35),
      Model(name: "LUROSA", image: 'assets/fronty/LUROSA_260.jpg', modelId: 36),
      Model(name: "MADERA", image: 'assets/fronty/MADERA_262.jpg', modelId: 37),
      Model(
          name: "MALAGA 2",
          image: 'assets/fronty/MALAGA_2_355.jpg',
          modelId: 38),
      Model(name: "MALAGA", image: 'assets/fronty/MALAGA_264.jpg', modelId: 39),
      Model(name: "MARCO", image: 'assets/fronty/MARCO_410.jpg', modelId: 40),
      Model(name: "MGO", image: 'assets/fronty/MGO_360.jpg', modelId: 41),
      Model(name: "MILOS", image: 'assets/fronty/MILOS_273.jpg', modelId: 42),
      Model(name: "MODENA", image: 'assets/fronty/MODENA_282.jpg', modelId: 43),
      Model(name: "MOIRA", image: 'assets/fronty/MOIRA_286.jpg', modelId: 44),
      Model(name: "MONA", image: 'assets/fronty/MONA_255.jpg', modelId: 45),
      Model(name: "MONTY", image: 'assets/fronty/MONTY_289.jpg', modelId: 46),
      Model(name: "NEAPOL", image: 'assets/fronty/NEAPOL_221.jpg', modelId: 47),
      Model(name: "NGO", image: 'assets/fronty/NGO_210.jpg', modelId: 48),
      Model(
          name: "NO_NAME2",
          image: 'assets/fronty/NO_NAME_2-1.jpg',
          modelId: 49),
      Model(name: "NO_NAME3", image: 'assets/fronty/NO_NAME3.jpg', modelId: 50),
      Model(name: "OIO", image: 'assets/fronty/OIO_90.jpg', modelId: 51),
      Model(name: "PALOMA", image: 'assets/fronty/PALOMA_218.jpg', modelId: 52),
      Model(name: "PARMA", image: 'assets/fronty/PARMA_353.jpg', modelId: 53),
      Model(name: "PAROS", image: 'assets/fronty/PAROS_283.jpg', modelId: 54),
      Model(name: "PATI", image: 'assets/fronty/PATI_256.jpg', modelId: 55),
      Model(name: "PIANTA", image: 'assets/fronty/PIANTA_362.jpg', modelId: 56),
      Model(name: "PILLOS", image: 'assets/fronty/PILLOS_292.jpg', modelId: 57),
      Model(name: "PILLOW", image: 'assets/fronty/PILLOW_253.jpg', modelId: 58),
      Model(name: "PORTYK", image: 'assets/fronty/PORTYK_428.jpg', modelId: 59),
      Model(name: "PRADA", image: 'assets/fronty/PRADA_462.jpg', modelId: 60),
      Model(name: "QGO", image: 'assets/fronty/QGO_278.jpg', modelId: 61),
      Model(name: "RAMIAK", image: 'assets/fronty/RAMIAK_470.jpg', modelId: 62),
      Model(name: "RAMKO", image: 'assets/fronty/RAMKO_222.jpg', modelId: 63),
      Model(name: "RAMONA", image: 'assets/fronty/RAMONA_252.jpg', modelId: 64),
      Model(
          name: "RAMPEL 60",
          image: 'assets/fronty/RAMPEL_60_209.jpg',
          modelId: 65),
      Model(
          name: "RAMPEL 360",
          image: 'assets/fronty/RAMPEL_360.jpg',
          modelId: 66),
      Model(name: "RAPINO", image: 'assets/fronty/RAPINO_357.jpg', modelId: 67),
      Model(name: "RAVENA", image: 'assets/fronty/RAVENA_210.jpg', modelId: 68),
      Model(name: "RAWA", image: 'assets/fronty/RAWA_284.jpg', modelId: 69),
      Model(name: "RBO", image: 'assets/fronty/RBO_105.jpg', modelId: 70),
      Model(name: "RENA", image: 'assets/fronty/RENA_359.jpg', modelId: 71),
      Model(name: "ROMA", image: 'assets/fronty/ROMA_104.jpg', modelId: 72),
      Model(name: "ROXANA", image: 'assets/fronty/ROXANA_238.jpg', modelId: 73),
      Model(name: "SANDRA", image: 'assets/fronty/SANDRA_286.jpg', modelId: 74),
      Model(name: "SEVERO", image: 'assets/fronty/SEVERO_362.jpg', modelId: 75),
      Model(name: "SIO", image: 'assets/fronty/SIO_408.jpg', modelId: 76),
      Model(name: "SPRINT", image: 'assets/fronty/SPRINT_002.jpg', modelId: 77),
      Model(name: "STRIPE", image: 'assets/fronty/STRIPE_243.jpg', modelId: 78),
      Model(name: "TAMARA", image: 'assets/fronty/TAMARA_280.jpg', modelId: 79),
      Model(name: "TELAIO", image: 'assets/fronty/TELAIO_407.jpg', modelId: 80),
      Model(name: "TEXAS", image: 'assets/fronty/TEXAS_238.jpg', modelId: 81),
      Model(name: "TGO", image: 'assets/fronty/TGO_209.jpg', modelId: 82),
      Model(name: "TORINO", image: 'assets/fronty/TORINO_257.jpg', modelId: 83),
      Model(name: "UGO", image: 'assets/fronty/UGO_258.jpg', modelId: 84),
      Model(
          name: "VARIO", image: 'assets/fronty/VARIO_lakier.jpg', modelId: 85),
      Model(name: "VEGA", image: 'assets/fronty/VEGA_267.jpg', modelId: 86),
      Model(name: "VERONA", image: 'assets/fronty/VERONA_259.jpg', modelId: 87),
      Model(name: "VIO", image: 'assets/fronty/VIO_417.jpg', modelId: 88),
      Model(name: "WAZA", image: 'assets/fronty/WAZA_35.jpg', modelId: 89),
      Model(name: "WDO", image: 'assets/fronty/WDO_287.jpg', modelId: 90),
      Model(
          name: "WENECJA", image: 'assets/fronty/WENECJA_464.jpg', modelId: 91),
      Model(name: "WIKI", image: 'assets/fronty/WIKI_238.jpg', modelId: 92),
      Model(name: "XDO", image: 'assets/fronty/XDO_424.jpg', modelId: 93),
      Model(name: "YDO", image: 'assets/fronty/YDO_250.jpg', modelId: 94),
      Model(name: "ZGO", image: 'assets/fronty/ZGO_46.jpg', modelId: 95),
      Model(name: "ZOBA", image: 'assets/fronty/ZOBA_04_238.jpg', modelId: 96),
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
                itemCount: models.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Order order = Order(
                          model: models[index].name,
                          color: '',
                          mdf: '',
                          height: 0,
                          width: 0,
                          type: "front",
                          modelId: models[index].modelId,
                          colorId: 0,
                          mdfId: 0,
                        );
                        print(jsonEncode(order.toJson()));
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
                            image: AssetImage(models[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            models[index].name,
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
