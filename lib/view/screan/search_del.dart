import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api/model/weather.data.dart';

class search extends SearchDelegate {
  //get http => null;

  getData(String q) async {
    String paseUrl =
        'http://api.weatherapi.com/v1/forecast.json?key=5ff5d622c43b45f188e191723220409&q=Iraq&days=1'; //جبت كود الي يرسل بيانات الطقس خليته داخل الكلاس ومن اضغط على كلمة سيرج واكتب كلمة عراق راح يجيب البيانات
    String apikey = '5ff5d622c43b45f188e191723220409';
    String lang = ' ar';

    final response =
        await http.get(Uri.parse('${paseUrl}key=${apikey}&q=${q}&lang=$lang '));
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
    //super.initState();
  }

  List<String> contryes = ['Iraq', 'Egypt', 'london', 'china'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            //query = ''; //تمسح الكتابه الي بمكان البحث
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchContryes = //دالة البحث عن اي كلمة في البيانات
        contryes.where((element) => element.contains(query)).toList();
    return ListView.separated(
      itemBuilder: ((context, index) => ListTile(
            //عرضت البيانات على شكل قائمة ومن اضغط على كلمة تنطبع
            title: query == ''
                ? Text(contryes[index])
                : Text(searchContryes[index]),
            onTap: () {
              getData(contryes[index]);
            },
          )),
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
      ),
      itemCount: query == '' ? contryes.length : searchContryes.length,
    );
  }
}
