import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:developer' as devtools show log;

import 'package:tech_idara_app/models/book.dart';

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
  BookResponse? obj;
  bool isLoading = false;

  TextEditingController controller = TextEditingController();
  String get searchKeyword => controller.text;
  // Example 1 with http Package
  callApi() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.https(
          "www.googleapis.com", "/books/v1/volumes", {"q": "$searchKeyword"});
      var response = await http.get(url);
      // http always get response in string then we decode it
      var stringReponse = response.body;
      // stringReponse.log();
      var decodedJson =
          convert.jsonDecode(stringReponse) as Map<String, dynamic>;
      // decodedJson.log();
      // decodedJson["totalItems"].toString().log();

      setState(() {
        obj = BookResponse.fromJson(decodedJson);
        isLoading = false;
      });
    } catch (e) {
      e.log();
      setState(() {
        obj = null;
        isLoading = false;
      });
    }
  }

  // @override
  // void initState() {
  //   callApi();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // callApi();
    // obj?.totalItems.toString().log();
    // obj?.items?.first.volumeInfo?.authors.toString().log();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex API'),
      ),
      body: Center(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: "Enter Book Name",
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: callApi,
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                ),
                // if (isLoading == false) const Text("No items Found"),
                if (!isLoading)
                  Expanded(
                    child: ListView.builder(
                      itemCount: obj?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BookDetail(
                                  bookFromList: (obj?.items![index])!),
                            ));
                          },
                          title:
                              Text(obj?.items?[index].volumeInfo?.title ?? ""),
                          leading: Image.network(obj?.items?[index].volumeInfo
                                  ?.imageLinks?.thumbnail ??
                              ""),
                          subtitle: Text(obj
                                  ?.items?[index].volumeInfo?.authors?.first
                                  .toString() ??
                              ""),
                        );
                      },
                    ),
                  ),
                if (isLoading) const Center(child: CircularProgressIndicator()),
              ],
            )),
      ),
    );
  }
}

class BookDetail extends StatefulWidget {
  // Main Door Of House getting value through constructor
  final Book bookFromList;
  const BookDetail({Key? key, required this.bookFromList}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late Book book;
  bool isLoading = false;
  callApiForDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.https(
        "www.googleapis.com",
        "/books/v1/volumes/${book.id}",
      );
      var response = await http.get(url);
      // http always get response in string then we decode it
      var stringReponse = response.body;
      // stringReponse.log();
      var decodedJson =
          convert.jsonDecode(stringReponse) as Map<String, dynamic>;
      // decodedJson.log();
      // decodedJson["totalItems"].toString().log();

      setState(() {
        book = Book.fromJson(json: decodedJson);
        isLoading = false;
      });
    } catch (e) {
      e.log();
      "Something went Wrong".log();
      setState(() {
        // Assigning Old Object Of the Main First page
        book = widget.bookFromList;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    book = widget.bookFromList;
    callApiForDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(book.volumeInfo?.title ?? ""),
            Image.network(
              book.volumeInfo?.imageLinks?.extraLarge ??
                  book.volumeInfo?.imageLinks?.thumbnail ??
                  "",
            ),
            if (isLoading) const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
