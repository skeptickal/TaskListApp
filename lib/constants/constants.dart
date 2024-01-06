import 'dart:io';

import 'package:flutter/material.dart';

String localhost = '${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:8080';
const Map<String, String> headers = {
  'Content-Type': 'application/json; charset=UTF-8',
};
Color bgColor = const Color.fromARGB(255, 48, 48, 48);
TextStyle tilesText = const TextStyle(color: Colors.white, letterSpacing: 2.0);
Color iconColor = const Color.fromARGB(255, 173, 173, 173);
Color black = Colors.black;
Color white = Colors.white;
Color drawerHeaderColor = const Color.fromARGB(255, 129, 128, 128);
