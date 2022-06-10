
import 'package:flutter/material.dart';

class CardModel{

  String value;
  String type;
  Color color;

  CardModel({
    required this.value,
    required this.type,
    required this.color,
  });


  @override
  bool operator == (Object other) {
    return (other is CardModel)
        && other.value == value
        && other.type == type
        && other.color == color;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;


}
