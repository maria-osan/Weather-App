import 'package:http/http.dart';
import 'dart:convert';
//import 'package:intl/intl.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

class Weather {
  late String city; // city name for the UI
  late String flag; // url to an assets flag icon
  late Map<String, dynamic> weather; // the weather in that city
  late String weatherMain;
  late String weatherDescription;
  late String temp;
  late String feelsLike;
  late String tempMin;
  late String tempMax;

  Weather({required this.city, required this.flag});

  Future<void> getWeather() async {
    try {
      /*// Load the environment variables from the .env file
      await dotenv.load(fileName: "lib/.env");
      // Access the environment variables using the env object
      String apiKey = dotenv.env['API_KEY']!;
      print(apiKey);*/

      // make the request
      String apiKey = '5aa842fffa8a28819d25ec76b0b299e5';
      Uri apiUrl = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
      Response response = await get(apiUrl);

      // get properties from data
      weather = json.decode(response.body);

      weatherMain = weather['weather'][0]['main'];
      weatherDescription = weather['weather'][0]['description'];

      double K = 273.15;
      double t = weather['main']['temp'] - K;
      temp = t.toStringAsFixed(2);
      t = weather['main']['feels_like'] - K;
      feelsLike = t.toStringAsFixed(2);
      t = weather['main']['temp_min'] - K;
      tempMin = t.toStringAsFixed(2);
      t = weather['main']['temp_max'] - K;
      tempMax = t.toStringAsFixed(2);
    } catch (e) {
      print('Caught error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    String apiKey = '5aa842fffa8a28819d25ec76b0b299e5';
    // String city = 'London,uk';
    Uri apiUrl = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');

    Response response = await get(apiUrl);

    if (response.statusCode == 200) {
      //Transform the temp from Kelvin to Celsius
      Map<String, dynamic> data = json.decode(response.body);
      double K = 273.15;
      double temp = data['main']['temp'] - K;

      print(data['name']); // city

      print(data['weather'][0]['main']); //Clear, Clouds, Rain
      print(data['weather'][0]['description']);

      print(double.parse(temp.toStringAsFixed(2)));
      print(data['wind']['speed']);

      // If the server returns a 200 OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load weather data');
    }
  }
}
