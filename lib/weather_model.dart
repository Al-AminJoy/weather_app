// To parse this JSON data, do
//
//     final weather = weatherFromMap(jsonString);

import 'dart:convert';

Weather weatherFromMap(String str) => Weather.fromMap(json.decode(str));

String weatherToMap(Weather data) => json.encode(data.toMap());

class Weather {
  Weather({
    required this.weather,
    required this.main,
    required this.name,
  });

  List<WeatherElement> weather;
  Main main;
  String name;
  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weather[0].icon}@2x.png';
  }
  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
    weather: List<WeatherElement>.from(json["weather"].map((x) => WeatherElement.fromMap(x))),
    main: Main.fromMap(json["main"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "weather": List<dynamic>.from(weather.map((x) => x.toMap())),
    "main": main.toMap(),
    "name": name,
  };
}

class Main {
  Main({
    required this.temp,
  });

  double temp;

  factory Main.fromMap(Map<String, dynamic> json) => Main(
    temp: json["temp"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "temp": temp,
  };
}

class WeatherElement {
  WeatherElement({
    required this.description,
    required this.icon,
  });

  String description;
  String icon;

  factory WeatherElement.fromMap(Map<String, dynamic> json) => WeatherElement(
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "description": description,
    "icon": icon,
  };
}
