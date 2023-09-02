import 'package:flutter/material.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/ui/app_theme.dart';
import 'package:todo_app/utils/date_utils.dart';
import 'package:todo_app/utils/dialog_utils.dart';

import '../../database/task_dataclass.dart';

class EditScreen extends StatefulWidget {
  Task task;

  EditScreen(this.task, {super.key});

  // var selectedDate=task.datetime;
  static const String routeName = 'EditeScreen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_light.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              'ToDo App',
              style: Theme.of(context).textTheme.headline4,
            ),
            centerTitle: true),
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: mediaQuery.height * 0.1,
              horizontal: mediaQuery.width / 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [BoxShadow(blurRadius: 10)]),
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Edit Task',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: mediaQuery.height / 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        initialValue: widget.task.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: MyTheme.lightPrimaryColor),
                        onChanged: (String val) {
                          widget.task.title = val;
                        },
                      ),
                      SizedBox(
                        height: mediaQuery.height / 20,
                      ),
                      TextFormField(
                        initialValue: widget.task.description,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: MyTheme.lightPrimaryColor),
                        onChanged: (String val) {
                          widget.task.description = val;
                        },
                      ),
                      SizedBox(
                        height: mediaQuery.height / 20,
                      ),
                      Text(
                        'Selected Time',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                          onTap: () {
                            showTaskDatePicker();
                            // showSelectedDatePicker();
                            // ()async{
                            //   var newDate=await showDatePicker(context: context,
                            //     initialDate: DateTime.now(),
                            //     firstDate: DateTime.now(),
                            //     lastDate: DateTime.now().add(Duration(days: 356),
                            //     ),
                            //   );
                            //   if(newDate ==null)return;
                            //   setState(() {
                            //     selectedDate=newDate;
                            //   });
                            // };
                          },
                          child: Text(
                            MyDateUtils.formatTaskDate(widget.task.datetime),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.grey),
                          )),
                      SizedBox(
                        height: mediaQuery.height / 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            updateTask();
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              side: const BorderSide(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text('Save Changes',
                              style: Theme.of(context).textTheme.headline4))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // DateTime selectedDate=widget.task.datetime;
  void showTaskDatePicker() async {
    var selectedPickerDate = await showDatePicker(
        context: context,
        initialDate: widget.task.datetime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (selectedPickerDate == null) {
      return;
    }

    setState(() {
      widget.task.datetime = selectedPickerDate;
    });
  }

  Future<void> updateTask() async {
    await MyDatabase.updateTask(widget.task);
    DialogUtils.showMessage(context, "Updated ", posActionTitle: "Ok",
        posAction: () {
      Navigator.pop(context);
    });
  }
}
