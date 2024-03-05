import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
// import 'package:weather_icons/weather_icons.dart';
// import 'package:weather_app/service/weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    try {
      data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
      print(data);
      
      // Set background image based on weather
      final weatherMain = data['weatherMain'];
      final bgImage = 'lib/assets/$weatherMain.png';

      return Scaffold(
        backgroundColor: Colors.blue[900],
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'city': result['city'],
                          'flag' : result['flag'],
                          'weatherMain': result['weatherMain'],
                          'weatherDescription': result['weatherDescription'],
                          'temp': result['temp'],
                          'feelsLike': result['feelsLike'],
                          'tempMin': result['tempMin'],
                          'tempMax': result['tempMax'],
                        };
                      });
                    },
                    icon: const Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Edit location',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['city'],
                        style: const TextStyle(
                          fontSize: 40.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${data['weatherMain']}: ${data['weatherDescription']}',
                    style: const TextStyle( 
                      fontSize: 20.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${data['temp']}°C",
                    style: const TextStyle(
                      fontSize: 55.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    "Feels like: ${data['feelsLike']}°C",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        WeatherIcons.thermometer,
                        color: Colors.white,
                      ),
                      Text(
                        "Max: ${data['tempMax']}°C",
                        style: const TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(
                        WeatherIcons.thermometer,
                        color: Colors.white,
                      ),
                      Text(
                        "Min: ${data['tempMin']}°C",
                        style: const TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Caught error: $e');
      return Scaffold(
        backgroundColor: Colors.blue[900],
      );
    }
  }
}