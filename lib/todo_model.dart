class Todo {
  String? title;
  String? description;
  String? category;
  int? timestamp;
  int? priority;
  String? userId;
  bool? isCompleted;
  String? id;
  String? user_id;

  Todo({
    this.title,
    this.description,
    this.category,
    this.timestamp,
    this.priority,
    this.userId,
    this.isCompleted,
    this.id,
    this.user_id,
  });

  // Example No 1
  // static List<Todo> fromJson(List<dynamic> myListOfTodo) {
  //   List<Todo> tempTodoList = [];
  //   for (var jsonMap in myListOfTodo) {
  //     var jsonObj = jsonMap as Map<String, dynamic>;
  //     tempTodoList.add(
  //       Todo(
  //         title: jsonObj['title'],
  //         description: jsonObj['description'],
  //         category: jsonObj['category'],
  //         timestamp: jsonObj['timestamp'],
  //         priority: jsonObj['priority'],
  //         userId: jsonObj['userId'],
  //         isCompleted: jsonObj['isCompleted'],
  //         id: jsonObj['id'],
  //         user_id: jsonObj['user_id'],
  //       ),
  //     );
  //   }
  //   return tempTodoList;
  // }

  // Example No 2
  static List<Todo> fromJson(List<dynamic> myListOfTodo) {
    List<Todo> tempTodoList = [];

    myListOfTodo.forEach((objectsOfJson) {
      var jsonMap = objectsOfJson as Map<String, dynamic>;
      tempTodoList.add(
        Todo(
          title: jsonMap['title'],
          description: jsonMap['description'],
          category: jsonMap['category'],
          timestamp: jsonMap['timestamp'],
          priority: jsonMap['priority'],
          userId: jsonMap['userId'],
          isCompleted: jsonMap['isCompleted'],
          id: jsonMap['id'],
          user_id: jsonMap['user_id'],
        ),
      );
    });
    return tempTodoList;
  }
}
