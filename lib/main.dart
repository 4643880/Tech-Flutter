import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tech_idara_app/models/all_category_model.dart';
import 'dart:developer' as devtools show log;
import 'dart:convert' as convert;

import 'package:tech_idara_app/models/login_model.dart';

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
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginResponse? response;
  UserData? userData;

  List<CategoryData>? listOfCategoryData;
  bool isLoading = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.http('ishaqhassan.com:2000', '/user/signin');
      var response = await http.post(url, body: {
        'email': _userNameController.text,
        'password': _passwordController.text,
      });

      var jsonString = response.body;
      var decodedJson = convert.jsonDecode(jsonString) as Map<String, dynamic>;

      var result = LoginResponse.fromJson(decodedJson);
      "----".log();
      result.data.toString().log();
      setState(() {
        userData = result.data;
        isLoading = false;
        _userNameController.clear();
        _passwordController.clear();
      });
      await getAllCategories();
    } catch (e) {
      e.log();
      "Something Went Wrong in Login API".log();
    }
  }

  Future getAllCategories() async {
    try {
      setState(() {
        // isLoading = true;
      });
      var url = Uri.http('ishaqhassan.com:2000', '/category');
      var response = await http.get(url,
          headers: {"Authorization": "Bearer ${userData?.accessToken}"});

      var jsonString = response.body;
      var decodedJson = convert.jsonDecode(jsonString) as Map<String, dynamic>;

      var resultOfCategory = AllCategories.fromJson(decodedJson);

      resultOfCategory.data.toString().log();

      setState(() {
        listOfCategoryData = resultOfCategory.data;
        // isLoading = false;
      });
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
                  if (userData == null) ...[
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
                        onPressed: login, child: const Text("Login")),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading)
                    Column(
                      children: [
                        if (userData?.email != null) ...[
                          const Text(
                            "These Are Your Login Credentials...",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Email: ${userData!.email}"),
                          Text("Password: ${userData!.password}"),
                          Text("Access Token: ${userData!.accessToken}"),
                          ElevatedButton(
                            onPressed: getAllCategories,
                            child: const Text("Show Categories"),
                          ),
                        ],
                      ],
                    ),
                  if (listOfCategoryData != null)
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: listOfCategoryData?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Image.network(
                              listOfCategoryData?[index].icon ?? "",
                            ),
                            title: Text(
                                listOfCategoryData?[index].title.toString() ??
                                    ""),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
