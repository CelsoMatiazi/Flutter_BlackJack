
import 'dart:math';
import 'package:flutter/material.dart';
import 'cardModel.dart';
import 'dialogMessage.dart';

class BlackJackController extends ChangeNotifier{

  List<CardModel> playerCards = [];
  List<CardModel> dealerCards = [];
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

  double widthCards = 200.0;
  double widthCardsDealer = 200.0;
  late BuildContext context;


  void changePlayer(bool player){
    isPlayerPlay = player;
    notifyListeners();
  }

  void setAzOneOrEleven(bool isOne){
    isOneOrEleven = isOne;
    playerScore = _sumCardValues(cards: playerCards);
    notifyListeners();
  }

  void getContext(BuildContext ctx){
    context = ctx;
  }

  Color _setCardColor(String type){
    if(type == "C" || type == "O") return Colors.red;
    return Colors.black;
  }

  saveCard(String player){
    var random = Random();
    var cardValueIndex = random.nextInt(13);
    var cardTypesIndex = random.nextInt(4);


    CardModel card = CardModel(
      value: cardValues[cardValueIndex],
      type: cardTypes[cardTypesIndex],
      color: _setCardColor(cardTypes[cardTypesIndex]),
    );

    if(player == "player"){
      if( !playerCards.contains(card) &&
          !dealerCards.contains(card) &&
          !firstDealerCard.contains(card)
      ) {
        playerCards.add(card);
      }else{
        saveCard("player");
      }
    }

    if(player == "dealer") {
      if( !playerCards.contains(card) &&
          !dealerCards.contains(card) &&
          !firstDealerCard.contains(card)
      ) {
        dealerCards.add(card);
      } else {
        saveCard("dealer");
      }
    }

    if(player == "first"){
      firstDealerCard.add(card);
    }

    playerScore = _sumCardValues(cards: playerCards);
    notifyListeners();
  }

  int _sumCardValues({
    required List<CardModel> cards,
    bool dealer = false
  }){
    int value = !dealer ? 0 : int.parse(firstDealerCard[0].value);
    for(int i = 0; i < cards.length; i++){
      value = value + _convertCardValue(cards[i].value);
    }
    return value;
  }

  int _convertCardValue(String value){
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
        widthCards = widthCards + 50;
      saveCard("player");

      if(_sumCardValues(cards: playerCards) > 21){
        _showMessage("Game Over");
        isPlayerPlay = false;
      }

      Future.delayed(Duration(milliseconds: 1300), (){
        playerScore = _sumCardValues(cards: playerCards);
      });
    }
    notifyListeners();
  }


  dealerIsPlaying(){
      dealerScore = _sumCardValues(cards: dealerCards) + _sumCardValues(cards: firstDealerCard) ;
      _dealerStopPlay();
      notifyListeners();
  }

  _dealerStopPlay() async {
    if(dealerScore <= playerScore ){
      await Future.delayed(Duration(seconds: 3));
      saveCard("dealer");
      dealerScore = _sumCardValues(cards: dealerCards) + _sumCardValues(cards: firstDealerCard) ;

      await Future.delayed(Duration(seconds: 1));
      _dealerStopPlay();

    }else{
      if(dealerScore > 21){
        _showMessage("You Win!!");
      }else{
        _showMessage("Game Over");
      }
    }

    notifyListeners();
  }


  resetGame(){
    playerCards = [];
    dealerCards = [];
    firstDealerCard = [];
    isStart = false;
    isOneOrEleven = true;
    isPlayerPlay = false;
    leftCards = -1;
    leftCardsDealer = -1;
    playerScore = 0;
    dealerScore = 0;
    notifyListeners();
  }

  _showMessage(String msg){
    Future.delayed(Duration(seconds: 1),(){
      gameMessage(context: context, message: msg);
    });

    Future.delayed(Duration(seconds: 4),(){
      Navigator.pop(context);
    });

  }
}