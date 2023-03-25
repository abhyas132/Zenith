import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:zenith/globalvariables.dart';
import 'package:zenith/provider/user_provider.dart';
import 'package:zenith/utils/emotion_face.dart';
import 'package:zenith/utils/excercise_tile.dart';
import 'package:zenith/utils/progress_indicator.dart';
import '../models/scheduleModel.dart';
import '../utils/getrequest.dart';
import '../utils/schedule_tile.dart';
import 'form_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  var ItemList = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, Samyak ',
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        color: Colors.blue[100],
                        fontSize: 18,
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
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.1,
            // ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    progress(),
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
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
    Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // ignore: unnecessary_new
          Column(
            children: [
              new CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 4.0,
                percent: 0.1,
                center: new Text("10%"),
                progressColor: Colors.red,
              ),
              Text("study")
            ],
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          Column(
            children: [
              new CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 4.0,
                percent: 0.30,
                center: new Text("30%"),
                progressColor: Colors.orange,
              ),
              Text("sports")
            ],
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          Column(
            children: [
              new CircularPercentIndicator(
                radius: 33.0,
                lineWidth: 4.0,
                percent: 0.60,
                center: new Text("60%"),
                progressColor: Colors.yellow,
              ),
              Text("others")
            ],
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          // new CircularPercentIndicator(
          //   radius: 25.0,
          //   lineWidth: 4.0,
          //   percent: 0.90,
          //   center: new Text("90%"),
          //   progressColor: Colors.green,
          // )
        ],
      ),
    ),
  ];
  List<ScheduleModel> schedule = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState;
    getData();
    // Future.delayed(Duration.zero, () {
    //   sports =
    //       Provider.of<UserProvider>(context, listen: false).user.sportActivity;
    //   study =
    //       Provider.of<UserProvider>(context, listen: false).user.studyActivity;
    //   others =
    //       Provider.of<UserProvider>(context, listen: false).user.otherActivity;
    // });
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
    // sports = user.sportActivity;
    // study = user.studyActivity;
    // others = user.otherActivity;
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SafeArea(
            child: Container(
          // width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width,
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
              //padding: EdgeInsets.all(25),
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        // aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: ItemList.map((card) {
                        return Builder(builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              // elevation: 5,
                              color: Colors.white,
                              child: card,
                            ),
                          );
                        });
                      }).toList(),
                    ),
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
                          itemBuilder: (context, index) => tile1(
                            //duration: schedule[index].duration.toString(),
                            starttime: schedule[index].startTime.toString(),
                            endtime: schedule[index].endTime.toString(),
                            task: schedule[index].title.toString(),
                            description: schedule[index].description.toString(),
                            indi: index,
                          ),
                        ),
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
