import 'package:flutter/material.dart';
import 'package:tech_idara_app/state.dart';
import 'package:tech_idara_app/user_model.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // User user;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(MyInheritedWidget.of(context).user!.name),
            Image.file(
              MyInheritedWidget.of(context).user!.image,
              height: 200,
              width: 200,
            ),
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: "Please Enter Your Name"),
            ),
            ElevatedButton(
              onPressed: () {
                // Creating New Object
                User newUser = User(
                  name: nameController.text,
                  image: MyInheritedWidget.of(context).user!.image,
                );

                // Updating Just Name
                MyInheritedWidget.of(context).updateUser(newUser);
                nameController.clear();
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
