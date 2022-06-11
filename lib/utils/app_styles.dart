import 'dart:ui';
import 'package:flutter/material.dart';

class AppStyles{

  static TextStyle bottomNavSelected = const TextStyle(
    color: Colors.white54,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
          offset: Offset(0, 0),
          blurRadius: 30.0,
          color: Colors.amber
      )
    ]
  );

  static TextStyle bottomNavUnselected = const TextStyle(
    color: Colors.white30,
    fontSize: 20,
  );

  static TextStyle body14White60 = const TextStyle(
    color: Colors.white60,
    fontSize: 14,
  );

  static TextStyle bodyWhite54Space = const TextStyle(
      color: Colors.white54,
      letterSpacing: 2
  );

  static TextStyle bodyBlack54Space = const TextStyle(
      color: Colors.black54,
      letterSpacing: 2
  );

  static TextStyle body14Black54 = const TextStyle(
      color: Colors.black54,
      fontSize: 14
  );

  static TextStyle body25White54Bold = const TextStyle(
      color: Colors.white54,
      fontSize: 25,
      fontWeight: FontWeight.bold
  );

  static TextStyle body22White54 = const TextStyle(
      color: Colors.white54,
      fontSize: 22
  );

  static BoxDecoration borderRadius12White54 = BoxDecoration(
      border: Border.all(color: Colors.white54),
      borderRadius: BorderRadius.circular(12)
  );


}