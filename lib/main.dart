import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer' as devtools show log;

import 'package:tech_idara_app/models/book.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookResponse? obj;
  bool isLoading = false;
  // Example 1 with http Package
  callApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.https(
          "www.googleapis.com", "/books/v1/volumes", {"q": "flutter"});
      var response = await http.get(url);
      // http always get response in string then we decode it
      var stringReponse = response.body;
      // stringReponse.log();
      var decodedJson =
          convert.jsonDecode(stringReponse) as Map<String, dynamic>;
      // decodedJson.log();
      // decodedJson["totalItems"].toString().log();

      setState(() {
        // Returning Data from Model Bacause I want to access here & assigning to myList
        obj = BookResponse.fromJson(decodedJson);
        isLoading = false;
      });
    } catch (e) {
      e.log();
    }
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // callApi();
    obj?.totalItems.toString().log();
    obj?.items?.first.volumeInfo?.authors.toString().log();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex API'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: (isLoading == true)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: obj?.items?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(obj?.items![index].volumeInfo?.title ?? ""),
                      leading: Image.network(obj?.items![index].volumeInfo
                              ?.imageLinks?.thumbnail ??
                          ""),
                      subtitle: Text(obj
                              ?.items![index].volumeInfo?.authors?.first
                              .toString() ??
                          ""),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
