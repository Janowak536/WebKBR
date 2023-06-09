import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:google_maps/google_maps.dart';

Widget getMap() {
  //A unique id to name the div element
  String htmlId = "6";
  //creates a webview in dart
  //ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final latLang = LatLng(50.03889907698633, 20.17803104603225);
    final mapOptions = MapOptions()
      ..zoom = 13
      ..tilt = 90
      ..center = latLang;
    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = "none";

    final map = GMap(elem, mapOptions);
    Marker(MarkerOptions()
      ..position = latLang
      ..map = map
      ..title = 'My position');
    Marker(MarkerOptions()
      ..position = LatLng(12.9557616, 77.7568832)
      ..map = map
      ..title = 'My position');
    return elem;
  });
  return HtmlElementView(
    viewType: htmlId,
  );
}
