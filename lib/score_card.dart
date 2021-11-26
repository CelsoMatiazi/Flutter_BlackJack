import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final String title;
  final int score;

  const ScoreCard({
    Key? key,
    required this.title,
    this.score = 0 ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 70,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.white38),),
          Divider(height: 5, color: Colors.white38,),
          Text(score.toString(), style: TextStyle(color: Colors.white38, fontSize: 35),)
        ],
      ),

    );
  }
}
