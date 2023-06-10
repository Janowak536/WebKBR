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
  String selectedColor = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final List<ColorModel> colors = [
      ColorModel(name: "Czerwony", image: 'assets/colors/red.jpg'),
      ColorModel(name: "Niebieski", image: 'assets/colors/blue.jpg'),
      // Dodaj więcej kolorów
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
                'Wybierz kolor frontu meblowego',
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
                        setState(() {
                          selectedColor = colors[index].name;
                        });
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
                            color: selectedColor == colors[index].name
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: selectedColor.isNotEmpty
                  ? () {
                      final updatedOrder =
                          widget.order.copyWith(color: selectedColor);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SillSizePage(order: updatedOrder),
                        ),
                      );
                    }
                  : null,
              child: Text('Dalej'),
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
