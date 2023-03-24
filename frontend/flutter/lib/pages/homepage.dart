import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zenith/utils/emotion_face.dart';
import 'package:zenith/utils/excercise_tile.dart';
import 'package:zenith/utils/progress_indicator.dart';
import 'form_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: SafeArea(
            //
            child: Column(children: [
          Container(
            //height: MediaQuery.of(context).size.height * 0.35,
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Samyak ',
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '25 March,23',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(1),
                      child: IconButton(
                        iconSize: 20,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddForm()));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'How do you feel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    progress(),
                    // Column(
                    //   children: [
                    //     emotionface(emoji: '😔'),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Text(
                    //       'Bad',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     emotionface(emoji: '🙂'),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Text(
                    //       'Fine',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     emotionface(emoji: '😀'),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Text(
                    //       'Well',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   children: [
                    //     emotionface(emoji: '😁'),
                    //     SizedBox(
                    //       height: 8,
                    //     ),
                    //     Text(
                    //       'Excellent',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Flexible(
            child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.grey[300]),
                //color: Colors.grey[200],
                padding:
                    EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
                child: Center(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Todays Sceduele',
                            style: GoogleFonts.varelaRound(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          //Icon(Icons.more_horiz)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                        child: ListView(
                      children: [tile(), tile(), tile(), tile()],
                    )),
                  ]),
                ),
              ),
            ]),
          ),
        ])));
  }
}
