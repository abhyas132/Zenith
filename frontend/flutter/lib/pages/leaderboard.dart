import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zenith/models/post.dart';

class leaderboard extends StatefulWidget {
  const leaderboard({super.key});

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  List<Post> leader = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LeaderBoard")),
        body: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "z",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[300]),
                          ),
                          Text(
                            "Zenpoints",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[300]),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Future<List<Post>?> getdata() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/v1/'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        leader.add(Post.fromJson(index));
      }
      return leader;
    } else {
      return leader;
    }
  }
}
