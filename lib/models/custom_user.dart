import 'package:flutter/material.dart';

class CustomUser {

  String name;
  String email;
  String address;
  String contact;
  List<dynamic> favorites;

  CustomUser({this.name = "null", @required this.email, this.address = "null", this.contact = "null", this.favorites});

  CustomUser.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.email = json["email"];
    this.address = json["address"];
    this.contact = json["contact"];
    this.favorites = json["favorites"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = this.name;
    data["email"] = this.email;
    data["address"] = this.address;
    data["contact"] = this.contact;
    data["favorites"] = this.favorites;
    return data;
  }

}