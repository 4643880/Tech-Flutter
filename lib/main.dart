import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer' as devtools show log;

import 'package:tech_idara_app/todo_model.dart';

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
  List<Todo> myTodoList = [];
  bool isLoading = false;
  // Example 1 with http Package
  callApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.https("63199b5b6b4c78d91b3f0a2f.mockapi.io", "/api/todos");
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      jsonResponse[0]["title"].toString().log();

      setState(() {
        // Returning Data from Model Bacause I want to access here & assigning to myList
        myTodoList = Todo.fromJson(jsonResponse);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock API Practice With Model'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: (isLoading == true)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: myTodoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(myTodoList[index].title.toString()),
                      subtitle: Text(myTodoList[index].description.toString()),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
