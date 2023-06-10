import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/login_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:flutter_2kbr/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class FrontyPage extends StatefulWidget {
  @override
  _FrontyPageState createState() => _FrontyPageState();
}

class _FrontyPageState extends State<FrontyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    var size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width > 800
        ? size.width * 0.2
        : 0.9; // Update this value as you need.

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
                  'Poniższe fronty meblowe są dostępne w różnorodnej kolorystyce',
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
                  child: GridView.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 3,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/3D_Lakier.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(8),
                        child: const Text("3D Lakier"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ABO_04.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ABO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ANDROS_035.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ANDROS 35'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ANSE_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ANSE'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/BARI_56.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('BARI'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/BBO_004.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('BBO 04'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/BBO_05.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('BBO 05'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/BOSTON_51.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('BOSTON'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/BREVE_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('BREVE'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/CASA_002.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('CASA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/CBO_11.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('CBO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/DELOS_290.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('DELOS'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/DEVON_076.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('DEVON'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/EBO_28.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('EBO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/FGO_33.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('FGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/FOLKI_354.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('FOLKI'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/GGO_012.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('GGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/GRIFF_000.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('GRIFF'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/HGO_50.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('HGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/IGO_215.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('IGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/JGO_219.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('JGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KANNA_214.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KANNA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KANTRY_261.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KANTRY'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KARBO_254.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KARBO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KBZ_272.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KBZ'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KLASYK_263.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KLASYK'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/KWADRO_416.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('KWADRO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/LAME_362.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('LAME'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/LBO_229.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('LBO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/LINDOS_237.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('LINDOS'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/LONDON_251.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('LONDON'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/LUROSA_260.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('LUROSA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MADERA_262.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MADERA_262'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MALAGA_2_355.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MALAGA_2'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MALAGA_264.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MALAGA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MARCO_410.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MARCO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MGO_360.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MILOS_273.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MILOS'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MODENA_282.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MODENA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MOIRA_286.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MOIRA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MONA_255.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MONA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/MONTY_289.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('MONTY'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/NEAPOL_221.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('NEAPOL'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/NGO_210.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('NGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/NO_NAME_2-1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('NO_NAME2'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/NO_NAME3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('NO_NAME3'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/OIO_90.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('OIO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PALOMA_218.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PALOMA_218'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PARMA_353.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PARMA_353'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PAROS_283.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PAROS_283'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PATI_256.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PATI'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PIANTA_362.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PIANTA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PILLOS_292.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PILLOS'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PILLOW_253.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PILLOW'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PORTYK_428.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PORTYK'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/PRADA_462.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('PRADA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/QGO_278.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('QGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAMIAK_470.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAMIAK'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAMKO_222.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAMKO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAMONA_252.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAMONA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/fronty/RAMPEL_60_209.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAMPEL 60'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAMPEL_360.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAMPEL 360'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAPINO_357.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAPINO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAVENA_210.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAVENA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RAWA_284.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RAWA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RBO_105.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RBO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/RENA_359.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('RENA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ROMA_104.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ROMA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ROXANA_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ROXANA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/SANDRA_286.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('SANDRA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/SEVERO_362.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('SEVERO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/SIO_408.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('SIO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/SPRINT_002.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('SPRINT'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/STRIPE_243.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('STRIPE'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/TAMARA_280.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('TAMARA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/TELAIO_407.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('TELAIO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/TEXAS_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('TEXAS'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/TGO_209.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('TGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/TORINO_257.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('TORINO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/UGO_258.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('UGO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/VARIO_lakier.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('VARIO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/VEGA_267.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('VEGA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/VERONA_259.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('VERONA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/VIO_417.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('VIO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/WAZA_35.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('WAZA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/WDO_287.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('WDO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/WENECJA_464.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('WENECJA'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/WIKI_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('WIKI'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/XDO_424.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('XDO'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/YDO_250.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('YDO'),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/fronty/ZGO_46.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text('ZGO')),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/fronty/ZOBA_04_238.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Text('ZOBA'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
