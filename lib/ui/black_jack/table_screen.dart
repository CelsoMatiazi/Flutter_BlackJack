import 'package:animated_card/animated_card.dart';
import 'package:black_jack/ui/black_jack/black_jack_controller.dart';
import 'package:black_jack/ui/black_jack/score_card.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card.dart';
import 'dialogMessage.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  late FlipCardController _controller;

  startGame() async {
    var bjController = Provider.of<BlackJackController>(context, listen: false);
    bjController.saveCard('first');

    await Future.delayed(Duration(seconds: 2));
    bjController.saveCard('dealer');

   await Future.delayed(Duration(seconds: 2));
   bjController.saveCard('player');

   await Future.delayed(Duration(seconds: 2));
     bjController.saveCard('player');
  }


  @override
  void initState() {
    _controller = FlipCardController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bjController = Provider.of<BlackJackController>(context);
    bjController.getContext(context);
    bjController.leftCards = -1;
    bjController.leftCardsDealer = -1;
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/table_bg.jpeg"),
                fit: BoxFit.cover
            )
        ),
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

                  if(bjController.isStart)
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
                                cardNumber: bjController.firstDealerCard[0].value,
                                color: bjController.firstDealerCard[0].color,
                                type: bjController.firstDealerCard[0].type,
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
                        width: bjController.widthCardsDealer + 15 ,
                        //height: 300,
                        child: bjController.dealerCards.isNotEmpty ? Stack(
                          children: [
                            Stack(
                              children: bjController.dealerCards.map((card) {
                                bjController.leftCardsDealer++;
                                return CardGame(
                                  cardNumber: card.value,
                                  color: card.color,
                                  type: card.type,
                                  index: bjController.leftCardsDealer,
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
            if(!bjController.isStart)
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      bjController.isStart = true;
                      bjController.isPlayerPlay = true;
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

            if(bjController.isStart)
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: bjController.widthCards + 30,
                  height: 300,
                  child: bjController.playerCards.isNotEmpty ? Stack(
                    children: [
                      Stack(
                        children: bjController.playerCards.map((card) {
                          bjController.leftCards++;
                          return CardGame(
                            cardNumber: card.value,
                            color: card.color,
                            type: card.type,
                            index: bjController.leftCards,
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

                      ScoreCard(title: "Guest", score: bjController.playerScore,),
                      ScoreCard(title: "Dealer", score: bjController.dealerScore,),
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

                         if(bjController.isPlayerPlay){
                           bjController.playerIsPlaying();
                         }

                        },
                      ),
                    ),


                    (bjController.playerCards.length < 2  || !bjController.isPlayerPlay) ? SizedBox():
                    GestureDetector(
                      onTap: () async {
                        bjController.changePlayer(false);
                        gameMessageSimple(context: context, message: "Dealer");
                        await Future.delayed(Duration(seconds: 3));
                        Navigator.pop(context);
                        _controller.toggleCard();
                        bjController.dealerIsPlaying();


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
                  onPressed: () {
                    //gameMessage(context: context, message: "ola");
                  }),
              IconButton(
                  icon: Icon(
                    Icons.hdr_auto_outlined,
                    size: 35,
                    color: bjController.isOneOrEleven ? Colors.grey : Colors.orange,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.amber[600],
                            content: Text("A carta A vale ${bjController.isOneOrEleven ? "11" : "1"}",
                              style: TextStyle(
                                  color: Colors.black
                              ),)
                        ));

                     bjController.setAzOneOrEleven(!bjController.isOneOrEleven);
                     //bjController.playerScore = bjController.sumCardValues(cards: playerCards);


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
                        bjController.resetGame();
                      }),
                  Text(" Reset", style: TextStyle(color: Colors.orange, fontSize: 10),)
                ],
              )
            ]
        )

    );
  }



}
