import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:salad_da/models/item.dart';


class FirebaseProvider extends ChangeNotifier {

  User user = FirebaseAuth.instance.currentUser;

  List<Item> items;

  setItem(Item item, File file) async {
    try {
      if (user != null && item != null) {
        item.imageUri = await uploadFile(item, file);
        item.editor = user.email;
        Map<String, dynamic> data = item.toJson();
        FirebaseFirestore.instance.collection("Items").doc(item.name).set(data);
      }
    } catch (e) {
      print(e);
    }
  }

  getItems() async {
    QuerySnapshot queryItems = await FirebaseFirestore.instance.collection(
        "Items").get();
    List<QueryDocumentSnapshot> queryDocument = queryItems.docs;
    List<Item> tempItem = queryDocument.map((index) => Item.fromSnapshot(index)).toList();
    tempItem.sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
    items = tempItem;
    notifyListeners();
  }

  Future<Item> getItemByName(String name) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection(
        "Items").doc(name).get();
    Item tempItem = Item.fromJson(documentSnapshot.data());
    return tempItem;
  }


  Future<String> uploadFile(Item item, File file) async {
    await FirebaseStorage.instance.ref("SaladImages").child(item.name).putFile(file);
    String url = await FirebaseStorage.instance.ref("SaladImages").child(item.name).getDownloadURL();
    if (url == null) {
      return null;
    }
    return url;
  }

}


// Future<void> addUser(
//     {String name, String price, String information, File photo}) {
//   // firestorage 에 사진 저장
//   // 사진 URI 받아오기
//   // doc 에 저장
//
//   // Call the user's CollectionReference to add a new user
//   CollectionReference ref = FirebaseFirestore.instance.collection("users");
//
//   // return ref
//   //     .add({
//   //       'full_name': fullName, // John Doe
//   //       'company': company, // Stokes and Sons
//   //       'age': age // 42
//   //     })
//   //     .then((value) => print("User Added"))
//   //     .catchError((error) => print("Failed to add user: $error"));
// }