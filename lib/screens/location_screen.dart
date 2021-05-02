import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// const apiKey = 'c59dfc6ab02dc797819f6a2da04bfde0';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  int condition;
  String cityName;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateWeather(widget?.locationWeather);
  }

  //main.temp
  void updateWeather(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Erorr';
        weatherMessage = 'Unable To Get Weather Data';
        cityName = '';
        return;
      }
      double temp = weatherData["main"]["temp"];
      temperature = temp?.toInt();
      weatherMessage = weather?.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather?.getWeatherIcon(condition);
      cityName = weatherData['name'];
      print(temperature);
    });
  }

  // Future getData() async {
  //   http.Response response = await http.get(Uri.parse(
  //       'http://api.openweathermap.org/data/2.5/weather?q=London&appid=$apiKey&units=metric'));
  //   // print(response.body);
  //   String data = response.body;
  //   double temp = jsonDecode(data)["main"]["temp"];
  //   temperature = temp?.toInt();
  //   condition = jsonDecode(data)['weather'][0]['id'];
  //   cityName = jsonDecode(data)['name'];
  //   print(temperature);
  // }

  @override
  Widget build(BuildContext context) {
    // print(widget.locationWeather);
    // print(temperature);
    // print(cityName);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateWeather(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typeName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typeName != null) {
                        var weatherData =
                            await weather.getCityWeather(typeName);
                        updateWeather(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ?? '🌩',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
