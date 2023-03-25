import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith/globalvariables.dart';

class progress extends StatelessWidget {
  const progress({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(seconds: 4),
      builder: (context, value, child) => SizedBox(
        height: 76,
        width: 76,
        child: CircularProgressIndicator(
          value: value,
          color: GlobalVariables.progresColor,
          backgroundColor: GlobalVariables.progresColor,
          strokeWidth: 10,
        ),
      ),
    );
  }
}
