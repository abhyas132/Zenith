import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:zenith/globalvariables.dart';
import 'package:zenith/models/post.dart';
import 'package:zenith/pages/search_page.dart';
import 'package:zenith/utils/getleaderboard.dart';
import 'package:zenith/utils/leaderBoardtile.dart';

import '../models/userModal.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

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
    TextEditingController txt = TextEditingController();
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("leaderboard"),
              actions: [
                AnimSearchBar(
                  width: MediaQuery.of(context).size.width * 0.8,
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(txt: value),
                      ),
                    );
                  },
                  textController: txt,
                  onSuffixTap: () {
                    setState(() {
                      txt.clear();
                    });
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                ListView.builder(
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
