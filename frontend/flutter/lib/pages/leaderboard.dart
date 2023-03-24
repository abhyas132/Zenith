import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
            Container(
              margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("User"), Text("ZenCoins")],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return LeaderBoardTile(
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
