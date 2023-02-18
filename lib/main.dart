import 'package:flutter/material.dart';
import 'package:todo_app/ui/app_theme.dart';

import 'ui/home/home_screen.dart';
import 'ui/home/settings/settings_tab.dart';
import 'ui/home/tasks_list/tasks_list_tab.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
        SettingsTab.routeName:(_)=>SettingsTab(),
        TasksListTab.routeName:(_)=>TasksListTab(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
