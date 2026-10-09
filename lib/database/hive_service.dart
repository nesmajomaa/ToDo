import 'package:hive_ce_flutter/adapters.dart';
import '../models/todo.dart';

class HiveService {
  String boxName = 'tasks';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  Box get box => Hive.box(boxName);

  Future<void> addTask(ToDo todo) async{
    await box.add({
      'title' : todo.title,
      'isComplete' : todo.isComplete,
    });
  }

  List<ToDo> getTasks() {
    List<ToDo> tasks = [];
    for (int i = 0; i < box.length; i++) {
      tasks.add(
        ToDo(
          title: box.getAt(i)['title'],
          isComplete: box.getAt(i)['isComplete'],
        ),
      );
    }
    return tasks;
  }

  Future<void> updateTask(int index, ToDo todo) async {
    await box.putAt(index, {
      'title': todo.title,
      'isComplete': todo.isComplete,
    });
  }

  Future<void> updateTaskStatus(int index) async {
    final task = Map<String, dynamic>.from(box.getAt(index));

    task['isComplete'] = !(task['isComplete'] ?? false);

    await box.putAt(index, task);
  }

  Future<void> deleteTask(int index) async {
    await box.deleteAt(index);
  }

}