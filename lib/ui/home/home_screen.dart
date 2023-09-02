import 'package:flutter/material.dart';

import 'add_task.dart';
import 'settings/settings_tab.dart';
import 'tasks_list/tasks_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [TasksListTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_light.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'ToDo App',
              style: Theme.of(context).textTheme.headline4,
            ),
            centerTitle: true),
        body: tabs[currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskBottomSheet();
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          // color: Colors.red,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex=index;
              });
              // currentTab();
            },
            currentIndex: currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ],
          ),
        ),
      ),
    );
  }

  void showAddTaskBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext){
      return const AddTask();
        });
  }

}
