import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Item {

  String name;
  num price;
  String imageUri;
  String information;
  num calorie;
  bool isOnSales;
  bool isTopSeller;
  String editor;
  DateTime uploadDate;

  Item({@required this.name, this.price = 0, this.imageUri, this.information = "", this.calorie = 0, this.isOnSales = true, this.isTopSeller = false, @required this.editor, this.uploadDate});

  Item.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.price = json["price"];
    this.imageUri = json["imageUri"];
    this.information = json["information"];
    this.calorie = json["calorie"];
    this.isOnSales = json["isOnSales"];
    this.isTopSeller = json["isTopSeller"];
    this.editor = json["editor"];
    String tempDate = json["uploadDate"];
    this.uploadDate = DateTime.parse(tempDate);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = this.name;
    data["price"] = this.price;
    data["imageUri"] = this.imageUri;
    data["information"] = this.information;
    data["calorie"] = this.calorie;
    data["isOnSales"] = this.isOnSales;
    data["isTopSeller"] = this.isTopSeller;
    data["editor"] = this.editor;
    data["uploadDate"] = this.uploadDate.toString();
    return data;
  }

  Item.fromSnapshot(QueryDocumentSnapshot snapshot) {
    this.name = snapshot.get("name");
    this.price = snapshot.get("price");
    this.imageUri = snapshot.get("imageUri");
    this.information = snapshot.get("information");
    this.calorie = snapshot.get("calorie");
    this.isOnSales = snapshot.get("isOnSales");
    this.isTopSeller = snapshot.get("isTopSeller");
    this.editor = snapshot.get("editor");
    String tempDate = snapshot.get("uploadDate");
    this.uploadDate = DateTime.parse(tempDate);
  }

}