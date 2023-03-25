import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:zenith/globalvariables.dart';
import 'package:zenith/models/post.dart';
import 'package:zenith/utils/getleaderboard.dart';
import 'package:zenith/utils/leaderBoardtile.dart';

import '../models/userModal.dart';

const url = GlobalVariables.baseUrl;

class leaderboard extends StatefulWidget {
  const leaderboard({super.key});

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  List<UserModal> users = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState;
    getData();
  }

  getData() async {
    GetLeaderBoard lb = GetLeaderBoard();
    await lb.getData();
    users = lb.users;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LeaderBoard")),
        body: SingleChildScrollView(
          child: Column(children: [
            // Container(
            //   // margin: EdgeInsets.only(left: 15, right: 15),
            //   padding: EdgeInsets.only(left: 12, right: 30),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: Colors.blue,
            //   ),
            //   margin: EdgeInsets.only(top: 15, left: 4, right: 4),
            //   height: MediaQuery.of(context).size.height * 0.09,
            // //   child: Row(
            // //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // //     children: [
            // //       Icon(
            // //         CupertinoIcons.add,
            // //       ),
            // //       SizedBox(
            // //         width: 3,
            // //       ),
            // //       Text("User",
            // //           style: GoogleFonts.poppins(
            // //               textStyle: GlobalVariables.textstylehead)),
            // //       Text("ZenCoins")
            // //     ],
            // //   ),
            // // ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return LeaderBoardTile(
                  index: index,
                  userId: users[index].userId,
                  name: users[index].name,
                  zenCoins: users[index].zenCoins,
                );
              },
            )
          ]),
        ));
  }
}
