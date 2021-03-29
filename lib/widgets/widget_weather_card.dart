import 'package:flutter/material.dart';
import 'package:salad_da/models/weather.dart';

class WeatherCardWidget extends StatefulWidget {
  WeatherData weatherData;

  WeatherCardWidget(this.weatherData);

  @override
  _WeatherCardWidgetState createState() => _WeatherCardWidgetState();
}

class _WeatherCardWidgetState extends State<WeatherCardWidget> {

  Image getIconImage() {
    String ic = widget.weatherData.data.current.weather.ic;
    if (ic.contains("n")) {
      ic = ic.replaceAll("n", "d");
    }
    var image = Image.network(
        "https://www.airvisual.com/images/$ic.png",
        fit: BoxFit.fitWidth,
      );
      return image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: getIconImage(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      country(),
                      SizedBox(height: 10),
                      weatherInfo(),
                    ],
                  ),
                ),
              ],
            ),
            // Row(
            //   children: List.generate(widget.weatherData.data.forecasts.length, (index){
            //     return Card();
            //   }),
            // )
          ],
        ),
      ),
    );
  }

  Container country() {
    return Container(
      child: Text(
        "${widget.weatherData.data.country}\n${widget.weatherData.data.city}",
        textAlign: TextAlign.right,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, fontFamily: "Roboto"),
      ),
      alignment: Alignment.centerRight,
    );
  }

  Widget weatherInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Temperature", textAlign: TextAlign.center),
                  Text("${widget.weatherData.data.current.weather.tp} \u2103",
                      textAlign: TextAlign.center),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Humidity", textAlign: TextAlign.center),
                  Text("${widget.weatherData.data.current.weather.hu} %",
                      textAlign: TextAlign.center),
                ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text("Wind speed", textAlign: TextAlign.center),
            Text("${widget.weatherData.data.current.weather.ws} m/s",
                textAlign: TextAlign.center),
          ]),
        ],
      ),
    );
  }
}
