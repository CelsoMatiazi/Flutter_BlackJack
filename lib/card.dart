
import 'package:animated_card/animated_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardGame extends StatelessWidget {

  final String cardNumber;
  final int index ;
  final Color color;
  final String type;
  final String size;

  CardGame({Key? key,
    required this.cardNumber,
    required this.index,
    required this.color,
    required this.type,
    required this.size
  }) : super(key: key);


  static const copa = "assets/copas.png";
  static const ouro = "assets/ouros.png";
  static const paus = "assets/paus.png";
  static const espada = "assets/espadas.png";


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
            height: size == "normal" ? 250 : 150,
            width: size == "normal" ? 180 : 90,
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
                  width: size == "normal" ? 35 : 17,
                  child: Column(
                    children: [
                      Text(cardNumber, style: TextStyle(fontSize: size == "normal" ? 30 : 20, fontWeight: FontWeight.bold, color: color),),
                      Image.asset(
                        type == "C" ? copa :
                        type == "O" ? ouro :
                        type == "P" ? paus : espada
                        , width: size == "normal" ? 30 : 15,)
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: size == "normal" ? 100 : 45,
                    height: size == "normal" ? 150 : 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)

                    ),
                    child: Image.asset(
                      type == "C" ? copa :
                      type == "O" ? ouro :
                      type == "P" ? paus : espada,
                      width: 35,)
                  ),
                ),
                Container(
                  width: size == "normal" ? 35 : 17,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        type == "C" ? copa :
                        type == "O" ? ouro :
                        type == "P" ? paus : espada,
                        width: size == "normal" ? 30 : 15,),
                      Text(cardNumber, style: TextStyle(fontSize: size == "normal" ? 30 : 20, fontWeight: FontWeight.bold, color: color),),
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

