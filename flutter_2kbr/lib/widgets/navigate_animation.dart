import 'package:flutter/material.dart';

Future<void> navigateWithoutAnimation(BuildContext context, Widget targetPage) {
  return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => targetPage,
        transitionDuration: Duration(seconds: 0),
      ));
}
