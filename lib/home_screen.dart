import 'package:flutter/material.dart';
import 'package:tech_idara_app/add_new_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: items.isNotEmpty
          ? ListView(
              children: items.map((strings) => itemWidget(strings)).toList(),
            )
          : const Center(
              child: Text("Items not found"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewJob(),
            ),
          ).then((value) => setState(() {
                items.add(value!);
              }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text),
                  ],
                ),
              ),
              // IconButton(
              //     onPressed: () {
              //       // setState(() {
              //       //   items.removeAt(index);
              //       // });
              //     },
              //     icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
