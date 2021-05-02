import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

// import 'package:http/http.dart' as http;
//&lat=${location.latitude}&lon=${location.longitude}
const apiKey = 'c59dfc6ab02dc797819f6a2da04bfde0';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';
const cityId = '2643743';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) {
    NetworkHelper networkHelper = NetworkHelper(
      Uri.parse('$openWeatherMapURL?&q=$cityName&appid=$apiKey&units=metric'),
    );
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);

    NetworkHelper networkHelper = NetworkHelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?&lat=31.0607872&lon=-0.1257&q=London&appid=c59dfc6ab02dc797819f6a2da04bfde0&units=metric'
        // '$openWeatherMapURL?&lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'
        ));
    var weatherData = await networkHelper.getData();
    print(weatherData);

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
