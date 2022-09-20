import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_idara_app/models/login_model.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var myEmail;
  var myPassword;
  var myAccessToken;

  @override
  void initState() {
    makeSureLoading();
    super.initState();
  }

  makeSureLoading() async {
    await loadFromLocal();
  }
  Future loadFromLocal() async {
    // Saving object into shared preferences
    final prefs = await SharedPreferences.getInstance();

    // Fetching Data
    if (prefs.containsKey("CREDENTIALS")) {
      String? data = prefs.getString("CREDENTIALS");
      final decodedData = json.decode(data ?? "");

      setState(() {
        UserData result = UserData.fromJson(decodedData);
        myEmail = result.email;
        myPassword = result.password;
        myAccessToken = result.accessToken;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main ")),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(myEmail ?? ""),
              Text(myPassword ?? ""),
              Text(myAccessToken ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
