class BookResponse {
  int? totalItems;
  List<Book>? items;

  BookResponse({this.totalItems, this.items});

  BookResponse.fromJson(Map<String, dynamic> json) {
    totalItems = json["totalItems"];
    if (json["items"] != null) {
      items = <Book>[];
      (json["items"] as List).forEach((book) {
        items?.add(Book.fromJson(json: book));
      });
    }
  }
}


class Book {
  String? id;
  VolumeInfo? volumeInfo;
  Book({this.volumeInfo});

  Book.fromJson({required Map<String, dynamic> json}) {
    id = json["id"];
    volumeInfo = VolumeInfo.fromjson(json: json["volumeInfo"]);
  }
}

class VolumeInfo {
  String? title;
  List<String>? authors;
  ImageLinks? imageLinks;

  VolumeInfo({this.title, this.authors, this.imageLinks});

  VolumeInfo.fromjson({required Map<String, dynamic> json}) {
    title = json["title"];
    authors = <String>[];
    (json["authors"] as List).forEach((element) {
      authors?.add(element);
    });
    imageLinks = ImageLinks.fromJson(json: json["imageLinks"]);
  }
}

class ImageLinks {
  String? thumbnail;

  ImageLinks({this.thumbnail});

  ImageLinks.fromJson({required Map<String, dynamic> json}) {
    thumbnail = json["thumbnail"];
  }
}
