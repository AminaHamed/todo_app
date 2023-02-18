import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import 'task_item.dart';

class TasksListTab extends StatelessWidget {
static const String routeName='TasksListTab';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child:Column(
        children: [
          CalendarTimeline(

            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
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
            child: ListView.builder(itemBuilder: (_,index){
              return TaskItem();
            },itemCount: 10,

            ),
          )
        ],
      ),
    );
  }
}
