import 'package:flutter/material.dart';

class BackgroundColorProvider extends ChangeNotifier {

  Color backgroundColor = Colors.white;

  Color get color => backgroundColor;

  ChangeColor(int index) {
    switch(index) {
      case 0:
        backgroundColor = Colors.white;
        break;
      case 1:
        backgroundColor = Colors.blueAccent;
        break;
      case 2:
        backgroundColor = Colors.green;
        break;
      case 3:
        backgroundColor = Colors.orangeAccent;
        break;
    }
    notifyListeners();
  }









}