import 'package:flutter/material.dart';
import 'package:zenith/utils/getuser.dart';

class emotionface extends StatelessWidget {
  final String emoji;
  const emotionface({
    super.key,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(12),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 28),
          ),
        ));
  }
}
