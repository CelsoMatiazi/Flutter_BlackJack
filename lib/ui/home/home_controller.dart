import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier{

  int menuIndex = 0;

  void bottomNavController(int index){
    menuIndex = index;
    notifyListeners();
  }

}