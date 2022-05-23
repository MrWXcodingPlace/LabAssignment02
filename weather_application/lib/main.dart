import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Weather App'),
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp = 0.0, hum = 0, desc = "No records", weather = "";

  String selectLoc = 'Changlun';
  List<String> locList = [
    'Changlun',
    'Jitra',
    'Alor Setar',
    'Baling',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Simple Weather',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            itemHeight: 60,
            value: selectLoc,
            onChanged: (newValue) {
              setState(() {
                selectLoc = newValue.toString();
              });
            },
            items: locList.map((selectLoc) {
              return DropdownMenuItem(
                child: Text(
                  selectLoc,
                ),
                value: selectLoc,
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: _loadWeather,
            child: const Text('Load Weather'),
          ),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _loadWeather() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      message: const Text("Progress"),
      title: const Text("Searching..."),
    );
    progressDialog.show();

    var apiid = "4062a8dfda89dd440496d1c4994d6937";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectLoc&appid=$apiid&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        temp = parsedJson['main']['temp'];
        hum = parsedJson['main']['humidity'];
        weather = parsedJson['weather'][0]['main'];
        desc =
            "The current weather in $selectLoc is $weather. The current temperature is $temp Celcius and humidity id $hum percent.";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
    progressDialog.dismiss();
  }
}
