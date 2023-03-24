import 'package:flutter/material.dart';

class LeaderBoardTile extends StatelessWidget {
  String? userId;
  String? name;
  int? zenCoins;
  LeaderBoardTile({this.userId, this.name, this.zenCoins});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(name!), Text(zenCoins.toString())],
      ),
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Color.fromARGB(255, 150, 243, 154)),
    );
  }
}
