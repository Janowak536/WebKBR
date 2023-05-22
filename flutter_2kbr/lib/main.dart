import 'package:flutter/material.dart';
import 'package:flutter_2kbr/pages/colors/material_colors.dart';
import 'package:flutter_2kbr/pages/home_page.dart';
import 'package:flutter_2kbr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Weather App',
        theme: ThemeData(
          primarySwatch: myPrimarySwatchColor,
        ),
        home: HomePage(),
      ),
    );
  }
}
