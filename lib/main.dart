import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyStateWidget extends InheritedWidget {
  final String userName = "Aizaz";

  const MyStateWidget({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MyStateWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyStateWidget>()!;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyStateWidget(
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
    final a = context.dependOnInheritedWidgetOfExactType<MyStateWidget>();
    print(MyStateWidget.of(context).userName);
    final b = MyStateWidget.of(context).userName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management With Inherited Widget'),
      ),
      body: Center(
        child: Text(
          b,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
