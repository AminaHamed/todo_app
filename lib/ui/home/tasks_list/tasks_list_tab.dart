import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task_dataclass.dart';

import 'task_item.dart';

class TasksListTab extends StatefulWidget {
  static const String routeName = 'TasksListTab';

  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
// List<Task>allTask=[];
// @override
//   void initState() {
//
//     loadTasks();
//   }
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) {
                return;
              }
              setState(() {
                selectedDate = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDatabase.getTasksRealTime(selectedDate),
              // future: MyDatabase.getTasks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError)
                  return const Center(
                    child: Text('Snapshot Error'),
                  );
                var tasks =
                    snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return TaskItem(tasks![index]);
                  },
                  itemCount: tasks?.length ?? 0,
                );
              },
            ),
          )
        ],
      ),
    );
  }

//   Future<void> loadTasks() async {
//     allTask=await MyDatabase.getTasks();
// setState(() {
// });
//   }
}
