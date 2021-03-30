import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salad_da/models/custom_user.dart';

class CustomUserProvider extends ChangeNotifier {
  CustomUser customUser;
  User user = FirebaseAuth.instance.currentUser;
  
  setCustomUser() async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(user.email).set(customUser.toJson());
      notifyListeners();
    } catch(e) {
      print(e);
    }
  }

  Future<void> getCustomUser() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Users").doc(user.email).get();
      customUser = CustomUser.fromJson(documentSnapshot.data());

      if (customUser.favorites == null) {
        customUser.favorites = <String>[];
      }

      notifyListeners();

    } catch(e) {
      print(e);
    }

  }


}