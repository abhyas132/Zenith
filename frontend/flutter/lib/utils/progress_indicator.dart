import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:flutter/material.dart';

class progress extends StatelessWidget {
  const progress({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
        animation: true,
        animationDuration: 10000,
        radius: 55,
        lineWidth: 10,
        percent: 0.8,
        progressColor: Color.fromARGB(255, 198, 150, 7),
        backgroundColor: Colors.deepPurple,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          "45",
          style: GoogleFonts.varelaRound(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 198, 150, 7),
              fontSize: 28,
            ),
          ),
        ));
  }
}
