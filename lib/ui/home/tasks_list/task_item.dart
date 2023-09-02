import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:todo_app/ui/app_theme.dart';
import 'package:todo_app/utils/dialog_utils.dart';

import '../../../database/task_dataclass.dart';
import '../edit_task_screen.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem(this.task, {super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildContext) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => EditScreen(widget.task)));
            // Navigator.pushNamed(context, EditScreen.routeName);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: widget.task.isDone
                        ? MyTheme.greenColor
                        : Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: widget.task.isDone
                                ? MyTheme.greenColor
                                : Theme.of(context).primaryColor),
                      ),
                      Text(
                        widget.task.description,
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    changeTaskState();
                  },
                  child: widget.task.isDone
                      ? const Text(
                          "Done!",
                          style: TextStyle(
                              color: MyTheme.greenColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 36,
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(
        context, "Are you sure you want to delete this task ?",
        posActionTitle: 'Yes', posAction: () async {
      DialogUtils.showProgressDialog(context, 'Deleting...');
      await MyDatabase.deleteTask(widget.task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "Task deleted successfully",
          posActionTitle: 'Ok');
    }, negActionTitle: 'No');
  }

  void changeTaskState() async {
    await MyDatabase.changeIsDoneState(widget.task);
    DialogUtils.showMessage(context, 'Task state is changed successfully',
        posActionTitle: 'Ok');
  }
}
