import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(const MyApp());
}

extension Log on Object {
  void log() => devtools.log(toString());
}

class MyStatefulWidget extends StatefulWidget {
  final Widget child;
  const MyStatefulWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  String userName = "Haider";

  updateName(String newName) {
    setState(() {
      userName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      state: this,
      child: widget.child,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final MyStatefulWidgetState state;

  const MyInheritedWidget({
    Key? key,
    required this.state,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MyStatefulWidgetState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!
        .state;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final a = context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    // a.toString().log();
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management With Inherited Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MyInheritedWidget.of(context).userName,
              style: Theme.of(context).textTheme.headline2,
            ),
            ElevatedButton(
                onPressed: () {
                  MyInheritedWidget.of(context).updateName("Husssain");
                },
                child: const Text("Update Name"))
          ],
        ),
      ),
    );
  }
}
