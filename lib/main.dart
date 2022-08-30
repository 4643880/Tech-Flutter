import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:tech_idara_app/job_post_model.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<JobPost> myList = [];

  bool scrollLimit = false;
  int? editIndex;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 100) {
        setState(() {
          scrollLimit = true;
        });
      } else {
        setState(() {
          scrollLimit = false;
        });
      }
      print(_scrollController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Listing'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration:
                                const InputDecoration(labelText: "Job title"),
                          ),
                          TextField(
                            controller: descController,
                            decoration: const InputDecoration(
                                labelText: "Job Description"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (editIndex == null) {
                                setState(() {
                                  JobPost obj = JobPost(
                                    title: titleController.text,
                                    desc: descController.text,
                                  );
                                  myList.add(obj);
                                  [titleController, descController].forEach(
                                    (element) => element.clear(),
                                  );
                                });
                              } else {
                                final existingObject = myList[editIndex!];
                                existingObject.title = titleController.text;
                                existingObject.desc = descController.text;

                                setState(() {
                                  myList[editIndex!] = existingObject;
                                  editIndex = null;
                                  [titleController, descController].forEach(
                                    (element) => element.clear(),
                                  );
                                });
                              }
                            },
                            child: Text(
                                "${editIndex == null ? "Submit" : "Update"} "),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: AnimatedContainer(
                duration: Duration(microseconds: 10),
                color: scrollLimit ? Colors.amber : Colors.white,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Index No# $index ${myList[index].title}",
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    myList.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    titleController.text = myList[index].title;
                                    descController.text = myList[index].desc;
                                    editIndex = index;
                                    editIndex.toString().log();
                                  });
                                },
                                icon: const Icon(Icons.edit),
                              )
                            ],
                          ),
                          subtitle: Text(myList[index].desc),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
