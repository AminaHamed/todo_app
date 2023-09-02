import 'package:flutter/material.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/database/task_dataclass.dart';

import '../../utils/date_utils.dart';
import '../../utils/dialog_utils.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  var selectedData = DateTime.now();
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add new Task',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                controller: titleController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please Enter a valid String';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: descController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return 'Please Enter a valid value';
                  }
                  if (input.length <= 3) {
                    return 'Length mast be > 3 character';
                  }
                  return null;
                },
                minLines: 4,
                maxLines: 4,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Select time:',
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                    onTap: () {
                      showTaskDatePicker();
                    },
                    child: Text(MyDateUtils.formatTaskDate(selectedData),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.grey))),
              ),
              ElevatedButton(
                  onPressed: () async {
                    insertTask();
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  void insertTask() async {
    //validate form
    if (formKey.currentState?.validate() == false) {
      return;
    }
    Task task = Task(
        title: titleController.text,
        description: descController.text,
        datetime: selectedData);
    //show loading
    DialogUtils.showProgressDialog(context, 'Loading...', isDismissible: false);
    //insert task
    try {
      await MyDatabase.insertTask(task);
      //hide loading
      DialogUtils.hideDialog(context);
      //show message task inserted
      DialogUtils.showMessage(context, 'Task inserted successfully',
          posActionTitle: 'OK', posAction: () {
        Navigator.pop(context);
      }, isDismissible: false);
    } catch (e) {
      DialogUtils.showMessage(
          context, 'Error while inserting message again later',
          posActionTitle: 'Try again',
          posAction: () {
            insertTask();
          },
          negActionTitle: 'Cancel',
          negAction: () {
            Navigator.pop(context);
          },
          isDismissible: true);
    }
  }

  void showTaskDatePicker() async {
    var selectedPickerDate = await showDatePicker(
        context: context,
        initialDate: selectedData,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (selectedPickerDate == null) {
      return;
    }

    setState(() {
      selectedData = selectedPickerDate;
    });
  }
}
