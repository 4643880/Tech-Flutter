import 'package:flutter/material.dart';
import 'package:tech_idara_app/main_page.dart';
import 'package:tech_idara_app/models/login_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as devtools show log;
import 'dart:convert' as convert;

extension Log on Object {
  void log() => devtools.log(toString());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserData? userData;
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  login(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      // Api Starts Here
      var url = Uri.http('ishaqhassan.com:2000', '/user/signin');
      var response = await http.post(url, body: {
        'email': _userNameController.text,
        'password': _passwordController.text,
      });

      var jsonString = response.body;
      var decodedJson = convert.jsonDecode(jsonString) as Map<String, dynamic>;
      var result = LoginResponse.fromJson(decodedJson);
      "Decoded".log();

      // Saving object into shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'CREDENTIALS',
        jsonEncode(result.data?.toJson()),
      );
      "Saved in pref".log();

      setState(() {
        userData = result.data;
        isLoading = false;
        _userNameController.clear();
        _passwordController.clear();
      });
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainPage(),
      ));
      // await getAllCategories();
    } catch (e) {
      e.log();
      "Something Went Wrong in Login API".log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Request Demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                children: [
                  if (!isLoading) ...[
                    TextField(
                      controller: _userNameController,
                      decoration:
                          const InputDecoration(labelText: "Enter User Name"),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: "Enter Password"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      child: const Text("Login"),
                    ),
                  ],
                  if (isLoading == true)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
