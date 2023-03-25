import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zenith/games/first/memory_screen.dart';
import 'package:zenith/games/game_screen.dart';
import 'package:zenith/globalvariables.dart';
import 'package:zenith/musicpage/music_screen.dart';
import 'package:zenith/yoga/yoga_home.dart';

class retention extends StatelessWidget {
  const retention({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relax Zone',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: GlobalVariables.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 70,
                  child: TextButton(
                      child: Text(
                        'Yoga',
                        style: TextStyle(color: GlobalVariables.textcolor),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => yoga_home()))),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 70,
                  child: TextButton(
                    child: Text(
                      "Meditation",
                      style: TextStyle(color: GlobalVariables.textcolor),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MusicScreen())),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: GlobalVariables.lightbackgroundColor,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 70,
                  child: TextButton(
                    child: Text(
                      "Games",
                      style: TextStyle(color: GlobalVariables.textcolor),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => GameScreen())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
