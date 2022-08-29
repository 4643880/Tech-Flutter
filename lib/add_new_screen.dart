import 'package:flutter/material.dart';

class Data {
  final String textOne;
  final String textTwo;

  Data({
    required this.textOne,
    required this.textTwo,
  });
}

class AddNewJob extends StatelessWidget {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Job")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: controller1,
            ),
            TextField(
              controller: controller2,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  Data(
                    textOne: controller1.text,
                    textTwo: controller2.text,
                  ),
                );
              },
              child: const Text("Save.."),
            ),
          ],
        ),
      ),
    );
  }
}
