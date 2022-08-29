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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller1.text  
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
