import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> tasks = FirebaseFirestore
      .instance
      .collection('tasks');

  // final tasks = FirebaseFirestore.instance.collection('tasks');

  // Add task
  Future<void> addTask(Task task) async {
    await tasks.add({
      'title': task.title,
      'isComplete': task.isComplete,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
    return tasks.snapshots();

    //get يترجع QuerySnapshot يعني ما بتظهر عطول عالشاشة (بحط معها Future)
    //snapshots بترجع stream يعني بتظهر عطول عالشاشة (بحط معها Stream)
  }

  // Update a task
  Future<void> updateTask(String taskId, Task task) async {
    await tasks.doc(taskId).update({
      'title': task.title,
      'isComplete': task.isComplete,
    });
  }

  // Update task status only
  Future<void> updateTaskStatus(String taskId, bool isComplete) async {
    await tasks.doc(taskId).update({'isComplete': isComplete});
  }

  // Delete a task
  Future<void> deleteTask(String taskId) async {
    await tasks.doc(taskId).delete();
  }
}
