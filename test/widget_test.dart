// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:salad_da/main.dart';
import 'package:salad_da/models/news.dart';
import 'package:salad_da/models/weather.dart';
import 'package:salad_da/utils/key_handler.dart';
import 'package:http/http.dart' as http;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance
      .collection("Items")
      .where("isOnSales", isEqualTo: true)
      .get()
      .then((value){
        print(value);
  });

  // Image image = Image.network(
  //   "https://www.airvisual.com/images/50n.png",
  //   fit: BoxFit.fitWidth,
  // );
  // Image image2 = Image.network(
  //   "https://www.airvisual.com/images/01d.png",
  //   fit: BoxFit.fitWidth,
  // );
  //
  // print(image.toString());
  // print(image2.toString());
  //
  // var url2 = Uri.https("www.airvisual.com", "/images/50n.png");
  // var response2 = await http.get(url2);
  // print(response2.body);
  // WeatherData weatherData = await GetWeatherData();
  // print(weatherData.data);
  // News newsData = await GetNews();
  // print(newsData.totalResults);
  // print(newsData.articles);
}

Future<News> GetNews() async {
  var url = Uri.https(newsEndPoint, "/v2/top-headlines",
      {"country": "us", "apiKey": "$newsApiKey"});
  var response = await http.get(url);

  switch (response.statusCode) {
    case 200:
      // OK
      break;
    case 400:
      print("Bad request");
      break;
    case 401:
      print("Unauthorized");
      break;
    case 429:
      print("Too many request");
      break;
    case 500:
      print("Server Error");
      break;
    default:
      print("other error : ${response.statusCode}");
      break;
  }

  return News.fromJson(json.decode(response.body));
}

Future<WeatherData> GetWeatherData() async {
  var url =
      Uri.https(weatherEndPoint, "/v2/nearest_city", {"key": "$weatherApiKey"});
  var response = await http.get(url);
  print(response.statusCode);

  switch (response.statusCode) {
    case 200:
      // OK
      break;
    case 400:
      print("Bad request");
      break;
    case 401:
      print("Unauthorized");
      break;
    case 429:
      print("Too many request");
      break;
    case 500:
      print("Server Error");
      break;
    default:
      print("other error : ${response.statusCode}");
      break;
  }
  return WeatherData.fromJson(json.decode(response.body));
}

// addData(dynamic data) {
//   // Map<String, dynamic> demoData = {
//   //
//   // };
//   // CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
//   // collectionReference.add(data);
// }
//
// fetchData() {
//   // read
//   // CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
//   // collectionReference.snapshots().listen((snapshot) {
//   // setState() {
//   // document = snapshot.documents[0].data;
//   // }
//   // });
// }
//
// // updateData() async {
// //   CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
// //   QuerySnapshot querySnapshot = await collectionReference.get();
// //   querySnapshot.docs[0].reference.update({"a": "data1", "b": "data2"});
// // }
//
// // deleteData() async {
// //   CollectionReference collectionReference = FirebaseFirestore.instance.collection("data");
// //   QuerySnapshot querySnapshot = await collectionReference.get();
// //   querySnapshot.docs[0].reference.delete();
// // }
//
// //
// // Fetch
// // Add
// // Update
// // Delete

