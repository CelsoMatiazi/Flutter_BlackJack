import 'dart:math';
import 'package:animated_card/animated_card.dart';
import 'package:black_jack/ui/black_jack/cardModel.dart';
import 'package:black_jack/ui/black_jack/score_card.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'dialogMessage.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  List<CardModel> playerCards = [];
  List<CardModel> dealer = [];
  List<CardModel> firstDealerCard = [];
  bool isStart = false;
  bool isOneOrEleven = true;
  bool isPlayerPlay = false;

  List cardValues = ["A","2","3","4","5","6","7","8","9","10","J","Q","K",];
  List cardTypes = ["C", "O", "P", "S"];
  int leftCards = -1;
  int leftCardsDealer = -1;

  int playerScore = 0;
  int dealerScore = 0;

  late FlipCardController _controller;

  double widthCards = 200.0;
  double widthCardsDealer = 200.0;

  Color setCardColor(String type){
    if(type == "C" || type == "O") return Colors.red;
    return Colors.black;
  }


  saveCard(String player){
    var random = Random();
    var cardValueIndex = random.nextInt(13);
    var naipeIndex = random.nextInt(4);

    CardModel card = CardModel(
        value: cardValues[cardValueIndex],
        type: cardTypes[naipeIndex],
        color: setCardColor(cardTypes[naipeIndex]),
    );

    if(player == "player"){
      if( !playerCards.contains(card) &&
          !dealer.contains(card) &&
          !firstDealerCard.contains(card)
      ) {
        playerCards.add(card);
      }else{
        saveCard("player");
      }
    }

    if(player == "dealer") {
      if (!playerCards.contains(card) &&
          !dealer.contains(card) &&
          !firstDealerCard.contains(card)
      ) {
        dealer.add(card);
      } else {
        saveCard("dealer");
      }
    }

    if(player == "first"){
      firstDealerCard.add(card);
    }

  }


  startGame() async {
    saveCard('first');

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      saveCard('dealer');
    });

   await Future.delayed(Duration(seconds: 2));
   setState(() {
     saveCard('player');
   });

   await Future.delayed(Duration(seconds: 2));
   setState(() {
     saveCard('player');
     playerScore = sumCardValues(cards: playerCards);
   });
  }


  int sumCardValues({
    required List<CardModel> cards,
    bool dealer = false
  }){
    int value = !dealer ? 0 : int.parse(firstDealerCard[0].value);
    for(int i = 0; i < cards.length; i++){
      value = value + convertCardValue(cards[i].value);
    }
    return value;
  }

  int convertCardValue(String value){
    if(int.tryParse(value) is int){
      return int.parse(value);
    }else{
      switch(value){
        case "A": {return isOneOrEleven ? 1 : 11;}
        default: { return 10; }
      }
    }
  }



  playerIsPlaying(){

    if(isPlayerPlay){
      setState(() {
        widthCards = widthCards + 50;
      });
      saveCard("player");

      if(sumCardValues(cards: playerCards) > 21){
        showMessage("Game Over");
        setState(() {
          isPlayerPlay = false;
        });
      }

      Future.delayed(Duration(milliseconds: 1300), (){
        setState(() {
          playerScore = sumCardValues(cards: playerCards);
        });
      });
    }
  }


  dealerIsPlaying(){
    gameMessage(context: context, message: "Dealer");
    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.pop(context);

      _controller.toggleCard();
      setState(() {
        dealerScore = sumCardValues(cards: dealer) + sumCardValues(cards: firstDealerCard) ;
      });

      dealerStopPlay(dealerScore);
    });

  }

  dealerStopPlay(int value){

    if(value <= playerScore ){
      Future.delayed(Duration(seconds: 3), (){
        setState(() {
          saveCard("dealer");
          dealerScore = sumCardValues(cards: dealer) + sumCardValues(cards: firstDealerCard) ;
        });
        dealerStopPlay(dealerScore);
      });
    }else{
      if(value > 21){
        showMessage("You Win!!");
      }else{
        showMessage("Game Over");
      }
    }

  }


  showMessage(String msg){
    Future.delayed(Duration(seconds: 1),(){
      gameMessage(context: context, message: msg);
    });

    Future.delayed(Duration(seconds: 4),(){
      Navigator.pop(context);
    });

  }



  resetGame(){
    playerCards = [];
    dealer = [];
    firstDealerCard = [];
    isStart = false;
    isOneOrEleven = true;
    isPlayerPlay = false;
    leftCards = -1;
    leftCardsDealer = -1;
    playerScore = 0;
    dealerScore = 0;
    setState(() {});
  }

  @override
  void initState() {
    _controller = FlipCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    leftCards = -1;
    leftCardsDealer = -1;
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

                  if(isStart)
                  AnimatedCard(
                    direction: AnimatedCardDirection.left,
                    initDelay: Duration(milliseconds: 0),
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.bounceOut,
                    child: FlipCard(
                      controller: _controller,
                      flipOnTouch: false,
                      back: Container(
                            width: 90,
                            height: 150,
                            child: CardGame(
                                cardNumber: firstDealerCard[0].value,
                                color: firstDealerCard[0].color,
                                type: firstDealerCard[0].type,
                                index: 0,
                                size: "mini"),
                      ),
                    front: Image.asset("assets/card.png"),
                ),
                  ),



                  Expanded(
                    child: SingleChildScrollView(
                      //physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: widthCardsDealer + 15 ,
                        //height: 300,
                        child: dealer.isNotEmpty ? Stack(
                          children: [
                            Stack(
                              children: dealer.map((card) {
                                leftCardsDealer++;
                                return CardGame(
                                  cardNumber: card.value,
                                  color: card.color,
                                  type: card.type,
                                  index: leftCardsDealer,
                                  size: "mini",
                                );
                              }).toList(),
                            ),

                            Container(color: Colors.transparent,)
                          ],
                        ): SizedBox(),
                      ),
                    ),
                  ),

                ],
              )
            ),



            //Player Card
            if(!isStart)
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      isStart = true;
                      isPlayerPlay = true;
                    });
                    startGame();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 230,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24, width: 5),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("START", style: TextStyle(
                      color: Colors.white24,
                      fontSize: 36
                    ),),
                  ),
                ),
              ),
            ),

            if(isStart)
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  height: 190,
                  width: (MediaQuery.of(context).size.width - 130) /2,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      ScoreCard(title: "Guest", score: playerScore,),
                      ScoreCard(title: "Dealer", score: dealerScore,),
                    ],
                  ),
                ),



                Stack(
                  alignment: Alignment.bottomRight,
                  children: [

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      height: 190,
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: GestureDetector(
                          child: Image.asset("assets/card.png"),
                        onTap: (){

                         if(isPlayerPlay){
                           playerIsPlaying();
                         }

                        },
                      ),
                    ),


                    (playerCards.length < 2  || !isPlayerPlay) ? SizedBox():
                    GestureDetector(
                      onTap: (){
                        dealerIsPlaying();
                        setState(() {
                          isPlayerPlay = false;
                        });
                      },
                      child: AnimatedCard(
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(bottom: 5, right: 5),
                          padding: EdgeInsets.only(right: 5,),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(.8),
                            shape: BoxShape.circle
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pan_tool,
                                size: 25,
                                color: Colors.black.withOpacity(.7),
                              ),
                              Text("  Stop", style: TextStyle(fontSize: 10),)
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            )
          ],
        ),

      ),



        floatingActionButton: FabCircularMenu(
            fabColor: Colors.black,
            ringColor: Colors.black54,
            fabCloseIcon: Icon(Icons.arrow_forward_ios, color: Colors.amber,),
            fabOpenIcon: Icon(Icons.star, color: Colors.amber,),
            ringWidth: 200,

            children: <Widget>[
              IconButton(
                  highlightColor: Colors.black,
                  splashColor: Colors.black,
                  splashRadius: 30,

                  icon: Icon(
                    Icons.home,
                    size: 35,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
              }),
              IconButton(
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    size: 40,
                    color: Colors.orange,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.hdr_auto_outlined,
                    size: 35,
                    color: isOneOrEleven ? Colors.grey : Colors.orange,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.amber[600],
                            content: Text("A carta A vale ${isOneOrEleven ? "11" : "1"}",
                              style: TextStyle(
                                  color: Colors.black
                              ),)
                        ));
                   setState(() {
                     isOneOrEleven = !isOneOrEleven;
                     playerScore = sumCardValues(cards: playerCards);
                   });

                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.refresh,
                        size: 35,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                       resetGame();
                      }),
                  Text(" Reset", style: TextStyle(color: Colors.orange, fontSize: 10),)
                ],
              )
            ]
        )

    );
  }



}
