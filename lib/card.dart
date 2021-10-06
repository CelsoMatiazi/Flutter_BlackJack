
import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardGame extends StatelessWidget {

  final String cardNumber;
  final int index ;
  final Color color;
  final String type;

  CardGame({Key? key,
    required this.cardNumber,
    required this.index,
    required this.color,
    required this.type
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      initDelay: Duration(milliseconds: 0),
      duration: Duration(milliseconds: 1000),
      curve: Curves.bounceOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: index * 50.0,),
          Container(
            padding: EdgeInsets.all(4),
            height: 250,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)

            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  child: Column(
                    children: [
                      Text(cardNumber, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color),),
                      Image.asset(
                        type == "C" ? "assets/copas.png" :
                        type == "O" ? "assets/ouros.png" :
                        type == "P" ? "assets/paus.png"  :
                        "assets/espadas.png"
                        , width: 30,)
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)

                    ),
                    child: Image.asset(
                      type == "C" ? "assets/copas.png" :
                      type == "O" ? "assets/ouros.png" :
                      type == "P" ? "assets/paus.png"  :
                      "assets/espadas.png",
                      width: 35,)
                  ),
                ),
                Container(
                  width: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        type == "C" ? "assets/copas.png" :
                        type == "O" ? "assets/ouros.png" :
                        type == "P" ? "assets/paus.png"  :
                        "assets/espadas.png",
                        width: 30,),
                      Text(cardNumber, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

