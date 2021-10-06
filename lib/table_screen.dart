import 'dart:math';
import 'package:black_jack/cardModel.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  List<CardModel> sequence = [];
  int leftCards = -1;
  List cardValues = ["A","2","3","4","5","6","7","8","9","10","J","Q","K",];
  List naipes = ["C", "O", "P", "S"];


  double widthCards = 200.0;

  Color setCardColor(String type){
    if(type == "C" || type == "O"){
      return Colors.red;
    }else{
      return Colors.black;
    }
  }

  saveCard(){
    var random = Random();
    var cardValueIndex = random.nextInt(13);
    var naipeIndex = random.nextInt(4);

    CardModel card = CardModel(
        value: cardValues[cardValueIndex],
        type: naipes[naipeIndex],
        color: setCardColor(naipes[naipeIndex])
    );

    if(!sequence.contains(card)){
      sequence.add(card);
    }else{
      saveCard();
    }

  }
  
  @override
  Widget build(BuildContext context) {
    leftCards = -1;
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 30,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              padding: EdgeInsets.all(10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              //color: Colors.amber,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Image.asset("assets/card.png"),

            ),

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: widthCards,
                  height: 300,
                  child: sequence.isNotEmpty ? Stack(
                    children: [
                      Stack(
                        children: sequence.map((card) {
                          leftCards++;
                          return CardGame(
                            cardNumber: card.value,
                            color: card.color,
                            type: card.type,
                            index: leftCards,
                          );
                        }).toList(),
                      ),

                      Container(color: Colors.transparent,)
                    ],
                  ): SizedBox(),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    height: 190,
                    width: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image.asset("assets/card.png"),
                  ),
                  onTap: (){
                      setState(() {
                        widthCards = widthCards + 50;
                      });

                     saveCard();
                  },
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}
