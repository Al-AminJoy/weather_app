import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/weather_model.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _cityController=TextEditingController();
  final dataService=DataService();
  var  _weatherResponse;
  var isLoaded=false;

  void _search ()  async {
    final response = await dataService.getWeather(_cityController.text);
    setState((){
      _weatherResponse =response;
      if(_weatherResponse.main.temp!=null && _weatherResponse.weather[0].description!=null && _weatherResponse.weather[0].icon!=null ){
        isLoaded=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Weather App'),
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoaded==true?
                  Column(
                    children: [
                      Image.network(_weatherResponse.iconUrl),
                      Text('${_weatherResponse.main.temp} F',style: TextStyle(fontSize: 40),),
                      Text(_weatherResponse.weather[0].description!=null?_weatherResponse.weather[0].description:''),
                    ],
                  ):Text(''),
                      SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _search,
                      child: Text('Search'))
                ],
              )
          ),
        ));
  }
}
/*
Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
if(_weatherResponse!=null)
Image.network(_weatherResponse.iconUrl),
// Text('${_weatherResponse.main.temp.toString()}',style: TextStyle(fontSize: 40),),
Text(_weatherResponse.weather[0].description),
SizedBox(
width: 150,
child: TextField(
controller: _cityController,
decoration: InputDecoration(
labelText: 'City',
),
),
),
ElevatedButton(
onPressed: _search,
child: Text('Search'))


],
),*/
