import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/database/task_dataclass.dart';
import 'package:todo_app/utils/date_utils.dart';

class MyDatabase {
  static CollectionReference<Task> getTasksCollection() {
    var tasksCollection = FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<Task>(
            fromFirestore: (snapshot, _) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, _) => task.toFireStore());
    return tasksCollection;
  }

  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDoc = tasksCollection.doc();
    task.id = taskDoc.id;
    task.datetime = MyDateUtils.extractDateOnly(task.datetime);
    return taskDoc.set(task);
  }

  static Future<List<Task>> getTasks(DateTime dateTime) async {
    var snapshot = await getTasksCollection()
        .where('datetime',
            isEqualTo:
                MyDateUtils.extractDateOnly(dateTime).millisecondsSinceEpoch)
        .get();
    var taskList = snapshot.docs.map((doc) => doc.data()).toList();
    return taskList;
  }

  static Future<void> deleteTask(Task task) {
    var taskDoc = getTasksCollection().doc(task.id);
    return taskDoc.delete();
  }

  static Stream<QuerySnapshot<Task>> getTasksRealTime(DateTime dateTime) {
    return getTasksCollection()
        .where('datetime',
            isEqualTo:
                MyDateUtils.extractDateOnly(dateTime).millisecondsSinceEpoch)
        .snapshots();
  }

  static markAsDone(Task task) {
    task.isDone = true;
    getTasksCollection().doc(task.id).set(task);
  }

  static Future<void> changeIsDoneState(Task task) async {
    var newVall = await getTasksCollection()
        .doc(task.id)
        .update({'isDone': !task.isDone});
    return newVall;
  }

  static Future<void> updateTask(Task task) async {
    var newEdit = await getTasksCollection().doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'datetime': task.datetime.millisecondsSinceEpoch
    });
    return newEdit;
  }
}
