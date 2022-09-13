import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer' as devtools show log;

import 'package:tech_idara_app/models/user_model.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<GithubUser> callApi() async {
    try {
      var url = Uri.https("api.github.com", "/users/aizazisonline");
      var response = await http.get(url);
      var stringReponse = response.body;
      var decodedJson =
          convert.jsonDecode(stringReponse) as Map<String, dynamic>;
      decodedJson.log();

      final result = GithubUser.fromJson(decodedJson);
      return result;
    } catch (e) {
      "Something went wrong...".log();
      throw "something went wrong in Api";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API With Future Builder")),
      body: Center(
        child: FutureBuilder<GithubUser>(
          future: callApi(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const CircularProgressIndicator();
              // return const Text("none");
              case ConnectionState.waiting:
                return const Text("waiting");

              case ConnectionState.active:
                return const Text("active");

              case ConnectionState.done:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data?.name ?? ""),
                      Image.network(
                        snapshot.data?.avatarUrl ?? "",
                        height: 100,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FormDemo(),
                            ));
                          },
                          child: const Text("Go to Form Page"))
                    ],
                  ),
                );
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

// Column of TextFields wrap with Form Widget
// TextFields replace with TextFormField Widget because it has validator property

// How Form will understand that you have written validator and it should trigger on onPressed  [ Form.of(context)?.validate(); ]

class FormDemo extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Demo"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  var notNullValue = value ?? "";
                  if (notNullValue.isEmpty && !notNullValue.contains("@")) {
                    return "Please Enter Valid Email";
                  }
                },
                controller: userNameController,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  var notNullValue = value ?? "";
                  if (notNullValue.isEmpty) {
                    return "Password Can't be Empty";
                  } else if (notNullValue.length < 8) {
                    return "Password length should be at least 8";
                  }
                  return null;
                },
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    // This return true or false
                    var getBoolValue = Form.of(context)?.validate();
                    if (getBoolValue ?? false) {
                      "Form Passed".log();
                    } else {
                      "Form Failed".log();
                    }
                  },
                  child: const Text("Login"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
