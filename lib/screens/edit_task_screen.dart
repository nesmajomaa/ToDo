import 'package:flutter/material.dart';

import '../database/firestore_service.dart';
import '../database/hive_service.dart';
import '../models/task.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  bool isLoaded = false;
  bool isSaving = false;

  late String taskId;
  late Task task;

  @override void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isLoaded) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      taskId = arguments['taskId'] as String;
      task = arguments['task'] as Task;

      titleController.text = task.title ?? '';

      isLoaded = true;
    }
  }

  Future<void> saveChanges() async {
    final newTitle = titleController.text.trim();

    if (newTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task title.'),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await firestoreService.updateTask(
        taskId,
        Task(
          title: newTitle,
          isComplete: task.isComplete,
        ),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update task. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),

      appBar: AppBar(
        title: const Text(
          'Tudee',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'CherryBomb',
          ),
        ),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 38,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Task',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF181827),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: Color(0xFF667085),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFD1D6DE),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF49BAF2),
                    Color(0xFF3A9CCD),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
              ),

              child: ElevatedButton(
                onPressed: isSaving ? null : saveChanges,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: isSaving
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Save changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }
}

// class _EditTaskScreenState extends State<EditTaskScreen> {
//   TextEditingController titleController = TextEditingController();
//   final HiveService hiveService = HiveService();
//   bool isLoaded = false;
//   late int index;
//   late Task task;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//
//     if (!isLoaded) {
//       // استقبال index من Home
//       final int index = ModalRoute.of(context)!.settings.arguments as int;
//
//       // جلب التاسك من Hive
//       task = hiveService.getTasks()[index];
//
//       // وضع العنوان القديم داخل TextField
//       titleController.text = task.title ?? '';
//
//       isLoaded = true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final int index = ModalRoute.of(context)!.settings.arguments as int;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCE8E8),
//       appBar: AppBar(
//         title: Text(
//           'Tudee',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'CherryBomb',
//           ),
//         ),
//         backgroundColor: Colors.lightBlue,
//         automaticallyImplyLeading: false,
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Edit Task",
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF181827),
//               ),
//             ),
//
//             const SizedBox(height: 18),
//
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(
//                 hintStyle: const TextStyle(color: Color(0xFF667085)),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 18,
//                 ),
//
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: const BorderSide(color: Color(0xFFD1D6DE)),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             Container(
//               width: double.infinity,
//               height: 56,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF49BAF2), Color(0xFF3A9CCD)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await hiveService.updateTask(
//                     index,
//                     Task(
//                       title: titleController.text,
//                       isComplete: true,
//                     ),
//                   );
//                   Navigator.pushNamed(context, '/home_screen');
//                 },
//
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.transparent,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text('Save changes', style: TextStyle(fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   @override
//   void dispose() {
//     titleController.dispose();
//     super.dispose();
//   }
// }
