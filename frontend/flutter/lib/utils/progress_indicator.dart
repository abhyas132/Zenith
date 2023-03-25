import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith/globalvariables.dart';

class progress extends StatelessWidget {
  const progress({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 0.37),
      duration: Duration(seconds: 2),
      builder: (context, value, child) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.1,
        child: CircularProgressIndicator(
          value: value,
          color: GlobalVariables.progresColor,
          backgroundColor: GlobalVariables.backgroundColor,
          strokeWidth: 10,
        ),
      ),
    );
  }
}
