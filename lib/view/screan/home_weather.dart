import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/model/weather.data.dart';

import 'search_del.dart';

class HomeWeather extends StatefulWidget {
  const HomeWeather({Key? key}) : super(key: key);

  @override
  State<HomeWeather> createState() => _HomeWeatherState();
}

class _HomeWeatherState extends State<HomeWeather> {
  getData(String q) async {
    String paseUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=5ff5d622c43b45f188e191723220409&q=Iraq&days=1';
    String apikey = '5ff5d622c43b45f188e191723220409';
    String lang = ' ar';
    String Url = '${paseUrl}key=${apikey}&q=${q}&lang=$lang ';
    print(Url);

    final response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response
          .body); //بهاي الطريقة اكدر اجيب بيانات مفصلة فقط الاسم والموقع وهكذا
      WeatherData weatherData = WeatherData(
          last_updated: data['current']['last_updated'],
          maxtemp_c: data['forecast']['forecastday'][0]['day']['maxtemp_c'],
          mintemp_c: data['forecast']['forecastday'][0]['day']['mintemp_c'],
          region: data['location']['region'],
          temp_c: data['current']['temp_c']);
      print(weatherData);
    }
  }

  @override
  void initState() {
    getData('Iraq');
    super.initState();
  }

//void getData(String s) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: search());
            },
            icon: Icon(Icons.search))
      ]),
      body: Container(),
    );
  }
}
