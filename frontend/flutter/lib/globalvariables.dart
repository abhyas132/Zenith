import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static const baseUrl = "http://172.16.128.190:3000/";
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 95, 191, 161);
  static const backgroundColor = Color(0xFF02aab0);
  static const secondaryColortile = Color.fromARGB(255, 162, 209, 195);
  static const backgroundColortile = Color.fromARGB(255, 92, 201, 205);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Color.fromARGB(221, 20, 12, 12);
  static const Color backgroundColor2 = Color(0xFF17203A);
  static const Color backgroundColorLight = Color(0xFFF2F6FF);
  static const Color backgroundColorDark = Color(0xFF25254B);
  static const Color shadowColorLight = Color(0xFF4A5367);
  static const Color shadowColorDark = Colors.black;
  static const Color progresColor = Color(0xFFddd6f3);
}
