import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundamental_parsing_json/Sample.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red,
        secondaryHeaderColor: Colors.orangeAccent,
        primarySwatch: Colors.red,
      ),
      home: const MainApp(),
    ));

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? _jsonContent;
  String? name;
  int? age;

  Map<String, dynamic> jsonSend = {};
  String jsonSendString = "";

  Future _loadSampleJson() async {
    String jsonString = await rootBundle.loadString("assets/sample.json");
    Map<String, dynamic> jsonData = json.decode(jsonString);
    Sample sample = Sample.fromJson(jsonData);
    setState(() {
      _jsonContent = jsonData.toString();
      name = sample.name!;
      age = sample.age!;
    });

    // Kirim Data JSON Biasa
    jsonSend["nama"] = "gaktau";
    jsonSend["umur"] = 20;
    jsonSendString = json.encode(jsonSend);
    print("json type $jsonSendString"); // json type {"nama":"gaktau","umur":20}

    // Kirim data json dengan Model
    Map<String, dynamic> sampleSend = Sample(name: "ayam", age: 5).toJson();
    print("Map type $sampleSend"); // Map type {name: ayam, age: 5}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter JSON",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // TODO: do something in here
                      _loadSampleJson();
                    },
                    child: const Text("Read JSON File"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  _jsonContent ?? "wait",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  name ?? "wait",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  age?.toString() ?? "wait",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
