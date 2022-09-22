import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_idara_app/api_response.dart';

void main() {
  runApp(const MyApp());
}

class MyAppState extends ChangeNotifier {
  AppUserModel? appUserModel;

  updateUser(AppUserModel? newAppUserModel) {
    appUserModel = newAppUserModel;
    notifyListeners();
  }
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
      home: ChangeNotifierProvider<MyAppState>(
        create: (context) => MyAppState(),
        builder: (context, child) {
          return const HomePage();
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  AppUserModel? callApi() {
    String json = """
{
    "message": "Success",
    "statusCode": 200,
    "data": {
        "id": 5,
        "email": "ishaq@ishaqhassan.com",
        "phone": "123",
        "password": "123456",
        "accessToken": "73d73320-82c4-4217-8ba1-0060d7ce4909"
    }
}
""";
    var decodedJson = jsonDecode(json);
    // Using Generic
    var result = ApiResponse<AppUserModel>.fromJson(
      decodedJson,
      AppUserModel.fromJson(decodedJson["data"]),
    );

    return result.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Provider.of<MyAppState>(context).appUserModel?.email ?? "",
              style: Theme.of(context).textTheme.headline5,
            ),
            ElevatedButton(
                onPressed: () {
                  // Writng false because setting value not getting
                  Provider.of<MyAppState>(context, listen: false)
                      .updateUser(callApi());
                },
                child: const Text("Update UI"))
          ],
        ),
      ),
    );
  }
}
