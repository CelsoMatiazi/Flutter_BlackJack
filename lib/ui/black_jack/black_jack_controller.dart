
import 'dart:math';
import 'package:flutter/material.dart';
import 'cardModel.dart';

class BlackJackController extends ChangeNotifier{

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

  Color setCardColor(String type){
    if(type == "C" || type == "O") return Colors.red;
    return Colors.black;
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


  saveCard(String player){
    var random = Random();
    var cardValueIndex = random.nextInt(13);
    var cardTypesIndex = random.nextInt(4);

    CardModel card = CardModel(
      value: cardValues[cardValueIndex],
      type: cardTypes[cardTypesIndex],
      color: setCardColor(cardTypes[cardTypesIndex]),
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
    notifyListeners();
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
    notifyListeners();
  }

}