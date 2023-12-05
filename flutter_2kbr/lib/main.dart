import 'package:flutter/material.dart';
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
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 27, 27, 27),
          ),
        ),
        title: '2KBR',
        home: HomePage(),
      ),
    );
  }
}
