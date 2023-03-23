import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class leaderboard extends StatefulWidget {
  const leaderboard({super.key});

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  getuserdata() async {
    var response = await http.get(Uri.parse('http://localhost:3000/api/v1/'));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
