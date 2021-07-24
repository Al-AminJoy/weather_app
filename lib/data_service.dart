import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';
class DataService{
  Future<Weather> getWeather(String city) async {
   // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final queryParameter = {
      'q':city ,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units':'imperial'};

    final uri  = Uri
        .https('api.openweathermap.org', 'data/2.5/weather',queryParameter);

    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return Weather.fromMap(json);
  }
}