import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salad_da/models/news.dart';
import 'package:salad_da/screens/screen_error.dart';
import 'package:salad_da/utils/key_handler.dart';
import 'package:salad_da/screens/screen_loading.dart';
import 'package:salad_da/widgets/widget_news_card.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  News newsData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return getNews();
      },
      color: Colors.pinkAccent,
      backgroundColor: Colors.lightGreenAccent,
      child: Container(
        color: Colors.white,
        child: FutureBuilder(
            future: getNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return NewsCardWidget(snapshot.data);
              }
              return ErrorScreen();
            }),
      ),
    );
  }

  Future<News> getNews() async {
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
    newsData = News.fromJson(json.decode(response.body));
    return News.fromJson(json.decode(response.body));
  }
}
