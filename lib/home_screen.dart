import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_idara_app/add_new_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Data> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return itemWidget(context, index);
              },
            )
          : const Center(
              child: Text("Items not found"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   items.add("Hello");
          // });
          Navigator.push<Data>(
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

  Widget itemWidget(BuildContext context, int index) {
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
                    Text(items[index].textOne),
                    Text(items[index].textTwo),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
