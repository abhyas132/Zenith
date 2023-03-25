import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zenith/globalvariables.dart';
import 'package:zenith/utils/emotion_face.dart';
import 'package:zenith/utils/excercise_tile.dart';
import 'package:zenith/utils/progress_indicator.dart';
import '../models/scheduleModel.dart';
import '../utils/getrequest.dart';
import '../utils/schedule_tile.dart';
import 'form_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ScheduleModel> schedule = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState;
    getData();
  }

  getData() async {
    GetRequest sc = GetRequest();
    await sc.getData();
    schedule = sc.schedules;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                GlobalVariables.backgroundColor,
                GlobalVariables.secondaryColor
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.4, 0.7],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(children: [
            Container(
              //height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    GlobalVariables.backgroundColor,
                    GlobalVariables.secondaryColor
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.4, 0.7],
                  tileMode: TileMode.repeated,
                ),
              ),
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, Samyak ',
                            style: GoogleFonts.varelaRound(
                              textStyle: TextStyle(
                                  color: Colors.blue[100],
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '25 March,23',
                            style: TextStyle(color: Colors.blue[100]),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Row(
                        children: [progress()],
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
                        'Your Progress',
                        style: TextStyle(
                            color: Colors.blue[100],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: Colors.white),
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
                        child: ListView.builder(
                            itemCount: schedule.length,
                            itemBuilder: (context, index) {
                              final item = schedule[index];
                              return Dismissible(
                                background: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 4,
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    color: Colors.green),
                                key: Key(item.uid!),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) => setState(() {
                                  schedule.removeAt(index);
                                }),
                                child: tile1(
                                  totaltask: schedule.length.toDouble(),
                                  starttime:
                                      schedule[index].startTime.toString(),
                                  endtime: schedule[index].endTime.toString(),
                                  task: schedule[index].title.toString(),
                                  description:
                                      schedule[index].description.toString(),
                                  indi: index,
                                ),
                              );
                            }),
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ]),
        )));
  }
}
