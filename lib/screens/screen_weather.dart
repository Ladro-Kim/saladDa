import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salad_da/models/weather.dart';
import 'package:salad_da/screens/screen_error.dart';
import 'package:salad_da/screens/screen_loading.dart';
import 'package:salad_da/utils/key_handler.dart';
import 'package:http/http.dart' as http;
import 'package:salad_da/widgets/widget_weather_card.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  Future<WeatherData> weatherData;

  @override
  void initState() {
    weatherData = GetWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return WeatherCardWidget(snapshot.data);
        }
        return ErrorScreen();
      },
    );
  }

  Future<WeatherData> GetWeatherData() async {
    var url = Uri.https(weatherEndPoint, "/v2/nearest_city",
        {
          "key": "$weatherApiKey"
        });
    var response = await http.get(url);

    switch(response.statusCode) {
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
}
