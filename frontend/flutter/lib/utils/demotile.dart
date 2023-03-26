import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenith/globalvariables.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class tile1 extends StatelessWidget {
  final String task;
  final String description;
  final String starttime;
  final String endtime;
  final double indi;
  tile1({
    super.key,
    required this.task,
    required this.description,
    required this.starttime,
    required this.endtime,
    required this.indi,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 26, right: 10, left: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 5.0,
              ),
            ],
            color: indi % 2 == 0
                ? GlobalVariables.backgroundColortile
                : GlobalVariables.secondaryColortile,
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: indi % 2 == 0
                          ? GlobalVariables.secondaryColor
                          : GlobalVariables.backgroundColor,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(16),
                  //
                  child: task == 'assignment'
                      ? Icon(CupertinoIcons.pen)
                      : task == 'study'
                          ? Icon(CupertinoIcons.book)
                          : task == 'excercise'
                              ? Icon(CupertinoIcons.sportscourt)
                              : task == 'hobby'
                                  ? Icon(CupertinoIcons.hand_draw)
                                  : Icon(CupertinoIcons.clock),
                ),

                ///
                ////
                ///
                ///
                ///
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 90,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          starttime,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          endtime,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}