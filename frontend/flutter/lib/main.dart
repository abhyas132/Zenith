import 'package:flutter/material.dart';
import 'package:zenith/pages/bodypage.dart';
import 'package:zenith/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: body_page(),
    );
  }
}
