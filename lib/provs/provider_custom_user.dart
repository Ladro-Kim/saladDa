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
    } catch(e) {
      print(e);
    }
  }

  getCustomUser() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Users").doc(user.email).get();
      print(CustomUser.fromJson(documentSnapshot.data()));
      customUser = CustomUser.fromJson(documentSnapshot.data());

      if (customUser.favorites == null) {
        customUser.favorites = <String>[];
      }
    } catch(e) {
      print(e);
    }

  }


}