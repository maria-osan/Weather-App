import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/service/weather.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWeather() async {
    Weather instance = Weather(city: 'Cluj', flag: 'RO.png');
    await instance.getWeather();
    Navigator.pushNamed(context, '/home', arguments: {
      'city': instance.city,
      'flag': instance.flag,
      'weatherMain': instance.weatherMain,
      'weatherDescription': instance.weatherDescription,
      'temp': instance.temp,
      'feelsLike' : instance.feelsLike,
      'tempMin' : instance.tempMin,
      'tempMax' : instance.tempMax,
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[00],
      body: const Center(
        child: SpinKitPulse(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}