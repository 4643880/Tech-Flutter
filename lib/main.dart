import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

// We use Future for Asynchronous Tasks
testIt1() async {
  print("Step 1");
  Future(
    () {
      print("Step 2");
    },
  );

  // then is try block & .catchError is catch block
  // If Future executes successfully after that then will get value
  Future.delayed(
    const Duration(seconds: 2),
    () => "Wait Completed Successfully After 2 seconds",
  ).then((value) => print(value));

  // Then will not execute due to exception now catching exception
  Future.delayed(
    const Duration(seconds: 2),
    () => throw "Wait Completed Exception",
  ).then((value) => print(value)).catchError((e) => print(e));

  // If Future executes successfully after that then will get value
  await Future.delayed(
    const Duration(seconds: 5),
    () => "Wait Completed Successfully 5 seconds",
  ).then((value) => print(value));

  print("Step-3");
  print("Database Opened");
}

testIt2() async {
  print("Before Opening DB");
  await testIt1();
  print("DB Opened Successfully");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testIt2();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // onGenerateRoute: (settings) {

      //   Map<String, Widget> pages = {
      //     "home/": const HomePage(),
      //     "about/": const AboutPage(),
      //   };

      //   return MaterialPageRoute(
      //     builder: (context) => pages[settings.name]!
      //   );

      // },

      // routes: {
      //   "about/": (context) => const AboutPage(),
      //   "home/": (context) => HomePage(),
      // },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? gettingBack;

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
            const Text("Data of Home Page", style: TextStyle(fontSize: 25)),
            Text(
              gettingBack ?? "",
              style: const TextStyle(fontSize: 25),
            ),
            ElevatedButton(
                onPressed: () {
                  // Easy Example 1
                  // Sending Data Forward & Receving Data back with push
                  Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AboutPage(title: "Sending Data Forward"),
                    ),
                  ).then((value) {
                    setState(() {
                      gettingBack = value;
                    });
                  });

                  // Navigator.pushNamed(context, "about/", arguments: {
                  //   "title": "how are you!",
                  //   "desc": "I am fine "
                  // }).then((value) {
                  //   value?.log();
                  //   setState(() {
                  //     gettingBack = value as String?;
                  //   });
                  // });
                },
                child: const Text("Go to About Page",
                    style: TextStyle(fontSize: 25))),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  final String? title;
  final String? desc;
  const AboutPage({Key? key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('About Page', style: TextStyle(fontSize: 25)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Data of About Page", style: TextStyle(fontSize: 25)),
            Text(title ?? "", style: const TextStyle(fontSize: 25)),
            Text(desc ?? ""),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  Navigator.pop<String>(context, "Sending Data Back");
                },
                child: const Text("Go to Home Page")),
          ],
        ),
      ),
    );
  }
}
