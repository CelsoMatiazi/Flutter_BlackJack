import 'dart:math';
import 'package:black_jack/cardModel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  List<CardModel> playerCards = [];
  List<CardModel> dealer = [];
  List<CardModel> firstDealer = [];

  List cardValues = ["A","2","3","4","5","6","7","8","9","10","J","Q","K",];
  List naipes = ["C", "O", "P", "S"];
  int leftCards = -1;

  late FlipCardController _controller;

  double widthCards = 200.0;

  Color setCardColor(String type){
    if(type == "C" || type == "O"){
      return Colors.red;
    }else{
      return Colors.black;
    }
  }




  saveCard(String player){
    var random = Random();
    var cardValueIndex = random.nextInt(13);
    var naipeIndex = random.nextInt(4);

    CardModel card = CardModel(
        value: cardValues[cardValueIndex],
        type: naipes[naipeIndex],
        color: setCardColor(naipes[naipeIndex]),
    );

    if(player == "player"){
      if( !playerCards.contains(card) &&
          !dealer.contains(card) &&
          !firstDealer.contains(card)
      ) {
        playerCards.add(card);
      }else{
        print("else Player");
        saveCard("player");
      }
    }


    if(player == "dealer") {
      if (!playerCards.contains(card) &&
          !dealer.contains(card) &&
          !firstDealer.contains(card)
      ) {
        dealer.add(card);
      } else {
        print("else dealer");
        saveCard("dealer");
      }
    }


    if(player == "first"){
      firstDealer.add(card);
    }else{
      saveCard("first");
    }

  }


  startGame()async{
   await Future.delayed(Duration(seconds: 5));
   setState(() {
   saveCard('player');
   });
   await Future.delayed(Duration(seconds: 2));
   setState(() {
     saveCard('player');
   });
  }



  @override
  void initState() {
    // TODO: implement initState
    _controller = FlipCardController();
    saveCard('first');
    saveCard('dealer');
    startGame();
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



            //Dealer
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
              child: Row(
                children: [

                  FlipCard(
                    controller: _controller,
                    //flipOnTouch: false,
                    back: Container(
                          width: 90,
                          height: 150,
                          child: CardGame(
                              cardNumber: firstDealer[0].value,
                              color: firstDealer[0].color,
                              type: firstDealer[0].type,
                              index: 0,
                              size: "mini"),
                    ),
                  front: Image.asset("assets/card.png"),
                ),




                  Container(
                    width: MediaQuery.of(context).size.width - 40 - 115,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                      dealer.map((card) {
                        return Stack(
                          children: [

                            FlipCard(
                              flipOnTouch: false,
                              front: Container(
                                width: 90,
                                height: 150,
                                child: CardGame(
                                  cardNumber: card.value,
                                  color: card.color,
                                  type: card.type,
                                  index: 0,
                                  size: "mini",
                                ),
                              ),
                              back: Image.asset("assets/card.png"),
                            ),
                            Container(
                              color: Colors.transparent,
                              width: 90,
                              height: 140,),
                          ],
                        );
                      }).toList()
                    ),
                  ),
                ],
              )
            ),



            //Player Card
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: widthCards + 30,
                  height: 300,
                  child: playerCards.isNotEmpty ? Stack(
                    children: [
                      Stack(
                        children: playerCards.map((card) {
                          leftCards++;
                          return CardGame(
                            cardNumber: card.value,
                            color: card.color,
                            type: card.type,
                            index: leftCards,
                            size: "normal",
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
                     saveCard("player");
                  },
                ),
              ],
            )
          ],
        ),

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          saveCard('dealer');

          //_controller.toggleCard();

          setState(() {});
        },
      ),

    );
  }



}
