import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? nameFromApi = "";
  // Example 1 with http Package
  callApi() async {
    try {
      setState(() {
        nameFromApi = null;
      });
      var url = Uri.https("api.github.com", "/users/aizazisonline");
      var response = await http.get(url);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      jsonResponse["name"].toString().log();
      setState(() {
        nameFromApi = jsonResponse["name"];
      });
    } catch (e) {
      e.log();
    }
  }

  // Example 2 without http Package
  parseJson() async {
    try {
      setState(() {
        nameFromApi = null;
      });
      const String url = "https://api.github.com/users/ishaquehassan";
      final result = await HttpClient()
          .getUrl(Uri.parse(url))
          .then((request) => request.close())
          .then((response) => response.transform(utf8.decoder).join())
          .then(
              (jsonString) => json.decode(jsonString) as Map<String, dynamic>);
      // .then((json) => json.map((map) => Person.fromJson(map)));
      result["name"].toString().log();
      setState(() {
        nameFromApi = result["name"];
      });
    } catch (e) {
      e.log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (nameFromApi != null)
              Text(
                nameFromApi!,
                style: const TextStyle(fontSize: 30),
              ),
            if (nameFromApi == null) const CircularProgressIndicator(),
            ElevatedButton(
              onPressed: callApi,
              child: const Text("Call API 1"),
            ),
            ElevatedButton(
              onPressed: parseJson,
              child: const Text("Call API 2"),
            ),
          ],
        ),
      ),
    );
  }
}
