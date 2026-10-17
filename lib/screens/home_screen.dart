import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/firestore_service.dart';
// import '../database/hive_service.dart';
import '../models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final HiveService hiveService = HiveService();
  final FirestoreService firestoreService = FirestoreService();
  // List<Task> tasks = [];
  String? userName;

  // int get doneCount => tasks.where((task) => task.isComplete == true).length;

  // int get todoCount => tasks.where((task) => task.isComplete == false).length;

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();

    String name = prefs.getString('name') ?? '';

    setState(() {
      userName = name;
    });
  }

  @override
  void initState() {
    super.initState();

    // tasks = hiveService.getTasks();
    loadName();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: const Color(0xFFFCE8E8),
    //
    //   appBar: AppBar(
    //     title: const Text(
    //       'Tudee',
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 26,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     backgroundColor: Colors.lightBlue,
    //     automaticallyImplyLeading: false,
    //   ),
    //
    //   body: Padding(
    //     padding: const EdgeInsets.only(
    //       left: 16,
    //       right: 16,
    //       top: 36,
    //     ),
    //
    //     child: Column(
    //       children: [
    //
    //         // Welcome Card
    //         Container(
    //           width: double.infinity,
    //           padding: const EdgeInsets.all(16),
    //
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.circular(16),
    //           ),
    //
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //
    //             children: [
    //
    //               Text(
    //                 'Welcome $userName',
    //                 style: const TextStyle(
    //                   fontSize: 21,
    //                   color: Color(0xFF444444),
    //                 ),
    //               ),
    //
    //               const SizedBox(height: 8),
    //
    //               Row(
    //                 children: [
    //
    //                   // Done
    //                   Expanded(
    //                     child: Container(
    //                       height: 110,
    //
    //                       decoration: BoxDecoration(
    //                         color: const Color(0xFF76C499),
    //                         borderRadius: BorderRadius.circular(18),
    //                       ),
    //
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //
    //                         children: [
    //
    //                           const Icon(
    //                             Icons.task_alt,
    //                             color: Colors.white,
    //                             size: 30,
    //                           ),
    //
    //                           const SizedBox(height: 8),
    //
    //                           Text(
    //                             '$doneCount',
    //                             style: const TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 24,
    //                             ),
    //                           ),
    //
    //                           const Text(
    //                             'Done',
    //                             style: TextStyle(
    //                               color: Colors.white70,
    //                               fontSize: 12,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //
    //                   const SizedBox(width: 18),
    //
    //                   // To-Do
    //                   Expanded(
    //                     child: Container(
    //                       height: 110,
    //
    //                       decoration: BoxDecoration(
    //                         color: const Color(0xFF9887F5),
    //                         borderRadius: BorderRadius.circular(18),
    //                       ),
    //
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //
    //                         children: [
    //
    //                           const Icon(
    //                             Icons.quiz_outlined,
    //                             color: Colors.white,
    //                             size: 30,
    //                           ),
    //
    //                           const SizedBox(height: 8),
    //
    //                           Text(
    //                             '$todoCount',
    //                             style: const TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 24,
    //                             ),
    //                           ),
    //
    //                           const Text(
    //                             'To-Do',
    //                             style: TextStyle(
    //                               color: Colors.white70,
    //                               fontSize: 12,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //         const SizedBox(height: 18),
    //
    //         Expanded(
    //           child: tasks.isEmpty
    //
    //           // No Tasks
    //               ? Align(
    //             alignment: Alignment.topCenter,
    //
    //             child: Container(
    //               width: double.infinity,
    //               height: 180,
    //               padding: const EdgeInsets.all(16),
    //
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(16),
    //               ),
    //
    //               child: const Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //
    //                 children: [
    //
    //                   Text(
    //                     'No tasks for today!',
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                       color: Color(0xFF444444),
    //                     ),
    //                   ),
    //
    //                   SizedBox(height: 3),
    //
    //                   Text(
    //                     'Tap the + button to add your first one.',
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       color: Colors.grey,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //
    //           // Tasks List
    //               : ListView.builder(
    //             padding: EdgeInsets.zero,
    //             itemCount: tasks.length,
    //
    //             itemBuilder: (context, index) {
    //
    //               final task = tasks[index];
    //
    //               return Padding(
    //                 padding: const EdgeInsets.only(bottom: 14),
    //
    //                 child: InkWell(
    //
    //                   // Open Edit Task Screen
    //                   onTap: () async {
    //
    //                     await Navigator.pushNamed(
    //                       context,
    //                       '/edit_task_screen',
    //                       arguments: index,
    //                     );
    //
    //                   },
    //
    //                   child: Container(
    //                     width: double.infinity,
    //                     height: 112,
    //                     padding: const EdgeInsets.all(12),
    //
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(16),
    //                     ),
    //
    //                     child: Column(
    //                       crossAxisAlignment:
    //                       CrossAxisAlignment.start,
    //
    //                       children: [
    //
    //                         // Status + Delete Icon
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //
    //                           children: [
    //
    //                             // Task Status
    //                             InkWell(
    //                               onTap: () async {
    //                                 await hiveService.updateTaskStatus(index);
    //
    //                                 setState(() {
    //                                   tasks = hiveService.getTasks();
    //                                 });
    //                               },
    //
    //                               child: Container(
    //                                 padding:
    //                                 const EdgeInsets.symmetric(
    //                                   horizontal: 22,
    //                                   vertical: 6,
    //                                 ),
    //
    //                                 decoration: BoxDecoration(
    //                                   color:
    //                                   task.isComplete == true
    //                                       ? const Color(
    //                                     0xFF76C499,
    //                                   )
    //                                       : const Color(
    //                                     0xFF9887F5,
    //                                   ),
    //
    //                                   borderRadius:
    //                                   BorderRadius.circular(20),
    //                                 ),
    //
    //                                 child: Text(
    //                                   task.isComplete == true
    //                                       ? 'Done'
    //                                       : 'ToDo',
    //
    //                                   style: const TextStyle(
    //                                     color: Colors.white,
    //                                     fontSize: 12,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //
    //                             // Delete Icon
    //                             InkWell(
    //                               onTap: () async {
    //
    //                                 await hiveService.deleteTask(index);
    //
    //                                 setState(() {
    //                                   tasks = hiveService.getTasks();
    //                                 });
    //                               },
    //
    //                               child: const Icon(
    //                                 Icons.delete_outline,
    //                                 color: Colors.red,
    //                                 size: 25,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //
    //                         const SizedBox(height: 10),
    //
    //                         // Task Title
    //                         Text(
    //                           task.title ?? '',
    //
    //                           style: const TextStyle(
    //                             fontSize: 19,
    //                             color: Color(0xFF444444),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //
    //   // Add Task Button
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () async {
    //       final result = await Navigator.pushNamed(
    //         context,
    //         '/add_task_screen',
    //       );
    //
    //       if (result == true) {
    //         setState(() {
    //           tasks = hiveService.getTasks();
    //         });
    //       }
    //     },
    //
    //     backgroundColor: const Color(0xFF40AFE0),
    //     foregroundColor: Colors.white,
    //     shape: const CircleBorder(),
    //
    //     child: const Icon(
    //       Icons.playlist_add,
    //       size: 30,
    //     ),
    //   ),
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),

      appBar: AppBar(
        title: const Text(
          'Tudee',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestoreService.getTasks(),
        builder: (context, snapshot) {
          // if (snapshot.hasError) {
          //   return const Center(
          //     child: Text('Something went wrong!'),
          //   );
          // }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final taskDocs = snapshot.data?.docs ?? [];

          final doneCount = taskDocs
              .where((doc) => doc.data()['isComplete'] == true)
              .length;

          final todoCount = taskDocs.length - doneCount;

          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 36,
            ),

            child: Column(
              children: [
                // Welcome Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome ${userName ?? ''}',
                        style: const TextStyle(
                          fontSize: 21,
                          color: Color(0xFF444444),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          // Done
                          Expanded(
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFF76C499),
                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.task_alt,
                                    color: Colors.white,
                                    size: 30,
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    '$doneCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),

                                  const Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 18),

                          // To-Do
                          Expanded(
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9887F5),
                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.quiz_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    '$todoCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),

                                  const Text(
                                    'To-Do',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Tasks List
                Expanded(
                  child: taskDocs.isEmpty

                  // No Tasks
                      ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No tasks for today!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF444444),
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            'Tap the + button to add your first one.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                  // Tasks List
                      : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: taskDocs.length,

                    itemBuilder: (context, index) {
                      final document = taskDocs[index];
                      final taskId = document.id;
                      final data = document.data();

                      final title =
                          data['title'] as String? ?? '';

                      final isComplete =
                          data['isComplete'] as bool? ?? false;

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                        ),

                        child: InkWell(
                          // Open Edit Task Screen
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              '/edit_task_screen',
                              arguments: {
                                'taskId': taskId,
                                'task': Task(
                                  title: title,
                                  isComplete: isComplete,
                                ),
                              },
                            );
                          },

                          child: Container(
                            width: double.infinity,
                            height: 112,
                            padding: const EdgeInsets.all(12),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,

                              children: [
                                // Status + Delete Icon
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                                  children: [
                                    // Task Status
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          await firestoreService
                                              .updateTaskStatus(
                                            taskId,
                                            !isComplete,
                                          );
                                        } catch (e) {
                                          if (!context.mounted) return;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Failed to update task.',
                                              ),
                                            ),
                                          );
                                        }
                                      },

                                      child: Container(
                                        padding: const EdgeInsets
                                            .symmetric(
                                          horizontal: 22,
                                          vertical: 6,
                                        ),

                                        decoration: BoxDecoration(
                                          color: isComplete
                                              ? const Color(0xFF76C499)
                                              : const Color(0xFF9887F5),

                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),

                                        child: Text(
                                          isComplete ? 'Done' : 'ToDo',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Delete Icon
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          await firestoreService
                                              .deleteTask(taskId);
                                        } catch (e) {
                                          if (!context.mounted) return;

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Failed to delete task.',
                                              ),
                                            ),
                                          );
                                        }
                                      },

                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                // Task Title
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Color(0xFF444444),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      // Add Task Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            '/add_task_screen',
          );
        },

        backgroundColor: const Color(0xFF40AFE0),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),

        child: const Icon(
          Icons.playlist_add,
          size: 30,
        ),
      ),
    );
    }

  }