import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';

import '../database/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HiveService hiveService = HiveService();
  await hiveService.init();
  runApp( MyApp(name: prefs.getString('name'),));
}

class MyApp extends StatelessWidget {
   final String? name;
   const MyApp({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: name != null? '/home_screen' : 'welcome_screen',
      routes: {
        '/welcome_screen': (context) => WelcomeScreen(),
        '/add_task_screen' : (context) => AddTaskScreen(),
        '/edit_task_screen' : (context) => EditTaskScreen(),
        '/home_screen' : (context) => HomeScreen(),
      },

      home: WelcomeScreen(),
    );
  }
}
