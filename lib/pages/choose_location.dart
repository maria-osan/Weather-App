import 'package:flutter/material.dart';
import 'package:weather_app/service/weather.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<Weather> weather = [
    Weather(city: 'Cluj', flag: "RO.png"),
    Weather(city: 'Tokyo', flag: 'JP.png'),
    Weather(city: 'New York', flag: 'US.png'),
    Weather(city: 'London', flag: 'UK.png'),
    Weather(city: "Paris", flag: 'FR.png'),
    Weather(city: "Singapore", flag: 'SG.png'),
    Weather(city: 'Dubai', flag: 'AE.png'),
    Weather(city: 'Hong Kong', flag: 'CN.png'),
    Weather(city: 'Istambul', flag: 'TR.png'),
    Weather(city: 'Seoul', flag: 'KR.png'),
    Weather(city: 'Bucharest', flag: 'RO.png'),
    Weather(city: 'Berlin', flag: 'DE.png'),
    Weather(city: 'Athens', flag: 'GR.png'),
    Weather(city: 'Cairo', flag: 'EG.png'),
    Weather(city: 'Nairobi', flag: 'KE.png'),
    Weather(city: 'Chicago', flag: 'US.png'),
    Weather(city: 'Jakarta', flag: 'ID.png'),
  ];

  void updateWeather(index) async {
    Weather instance = weather[index];
    await instance.getWeather();

    print(instance.weatherMain);

    // navigate to home screen
    Navigator.pop(context, {
      'city': instance.city,
      'flag' : instance.flag,
      'weatherMain': instance.weatherMain,
      'weatherDescription': instance.weatherDescription,
      'temp': instance.temp,
      'feelsLike' : instance.feelsLike,
      'tempMin' : instance.tempMin,
      'tempMax' : instance.tempMax,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.grey[200],
        title: const Text('Choose a location'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: weather.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateWeather(index);
                },
                title: Text(weather[index].city),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/${weather[index].flag}'),
                  ),
              ),
            ),
          );
        },
      ),
    );
  }
}