import 'package:flutter/material.dart';
import 'package:tech_idara_app/user_model.dart';

class MyStatefulWidget extends StatefulWidget {
  final Widget child;
  const MyStatefulWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  User? user;

  updateUser(User newUser) {
    setState(() {
      user = newUser;
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
