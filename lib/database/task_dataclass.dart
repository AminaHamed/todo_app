class Task {
  String id;
  String title;
  String description;
  DateTime datetime;
  bool isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.datetime,
      this.isDone = false});

//to send data from this class to firebase
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'datetime': datetime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }

//named constructor to covert data from firebase to task
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            datetime: DateTime.fromMillisecondsSinceEpoch(data['datetime']),
            isDone: data['isDone']);
}
