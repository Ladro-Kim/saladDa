import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salad_da/screens/screen_account.dart';
import 'package:salad_da/screens/screen_cart.dart';
import 'package:salad_da/screens/screen_home.dart';
import 'package:salad_da/screens/screen_info.dart';

class BottomIndexProvider extends ChangeNotifier {

  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar), label: "Buy"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Account"),
  ];

  List<Widget> pages = [
    HomeScreen(),
    InfoScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  Widget get page => pages[currentIndex];


  void ChangeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}