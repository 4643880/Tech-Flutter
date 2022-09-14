import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_idara_app/profile_page.dart';
import 'dart:developer' as devtools show log;

import 'package:tech_idara_app/state.dart';
import 'package:tech_idara_app/user_model.dart';

void main() {
  runApp(const MyApp());
}

extension Log on Object {
  void log() => devtools.log(toString());
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
  final TextEditingController _nameController = TextEditingController();

  pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    var myAppState = MyInheritedWidget.of(context);
    pickedImage?.path.toString().log();
    myAppState.updateUser(
      User(
        name: _nameController.text,
        image: File(pickedImage?.path ?? ""),
      ),
    );
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _state = MyInheritedWidget.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management With Inherited Widget'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProfilePage())));
                  },
                  child: const Text("Go to Profile"),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: "Please Enter Your Name"),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImage(context);
                  },
                  child: const Text("Please Pick Image"),
                ),
                Text(
                  _state.user?.name ?? "",
                  style: Theme.of(context).textTheme.headline2,
                ),
                if (_state.user != null)
                  Image.file(
                    MyInheritedWidget.of(context).user!.image,
                    height: 200,
                    width: 200,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
