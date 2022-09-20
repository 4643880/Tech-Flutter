import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_idara_app/login_page.dart';
import 'dart:developer' as devtools show log;
import 'dart:convert' as convert;

import 'package:tech_idara_app/models/login_model.dart';

import 'main_page.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserData? data;

  @override
  void initState() {
    loadFromLocal();
    super.initState();
  }

  loadFromLocal() async {
    // Saving object into shared preferences
    final prefs = await SharedPreferences.getInstance();

    // Fetching Data
    if (prefs.containsKey("CREDENTIALS")) {
      String? getdata = prefs.getString("CREDENTIALS");
      final decodedData = json.decode(getdata ?? "");

      setState(() {
        data = UserData.fromJson(decodedData);
      });
    }
    print("loaded");

    // Remove data for the 'counter' key.
    // final success = await prefs.remove('CREDENTIALS');
    // print("Deleted...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (data?.accessToken == null) ? const LoginPage() : MainPage(),
    );
  }
}



// void saveDataLocally(BuildContext context) async {
// var gettingBool = Form.of(context)?.validate();

// if (gettingBool == true) {
//   final prefs = await SharedPreferences.getInstance();
//   // Save an String value to 'action' key.
//   await prefs.setString('name', nameController.text);

//     String jsonResponse = '''
//       {
//           "message": "Success",
//           "statusCode": 200,
//           "data": {
//               "id": 5,
//               "email": "ishaq@ishaqhassan.com",
//               "phone": "123",
//               "password": "123456",
//               "accessToken": "3a38a061-8e1f-45fb-a892-c8af38c8b00f"
//           }
//       }
//     ''';

//     var result = UserLoginModel.fromJson(jsonDecode(jsonResponse));
//     // Save an String value to 'action' key.
//     await prefs.setString(
//       'CREDENTIALS',
//       jsonEncode(result.data?.toJson()),
//     );
//   }
// }

// @override
// void initState() {
//   loadFromLocal();
//   super.initState();
// }

// loadFromLocal() async {
//   final prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey("CREDENTIALS")) {
//     String? data = prefs.getString("CREDENTIALS");
//     UserData result = UserData.fromJson(jsonDecode(data ?? ""));
//     nameController.text = result.accessToken ?? "";
//   }
// }

