import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController taskController = TextEditingController();
  final database = Hive.box("database");
  List task_list = []; // Added as a class field

  @override
  void initState() {
    super.initState();
    task_list = database.get("TODO_LIST") ?? [];
  }

  void addTask(String task) {
    setState(() {
      task_list.add(task);
      database.put("TODO_LIST", task_list);
    });
  }

  void deleteTask(int index) {
    setState(() {
      task_list.removeAt(index);
      database.put("TODO_LIST", task_list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(title: const Text("Local Storage with Hive")),
      // home body
      body: task_list.isEmpty
          ? const Center(child: Text("No tasks yet! Add one below."))
          : ListView.builder(
              itemCount: task_list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(task_list[index]) ,
                  trailing:  IconButton(
                    onPressed: () => deleteTask(index),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),

      // bottom navigation bar
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add New Task"),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter task here",
                      ),
                      controller: taskController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          if (taskController.text.isNotEmpty) {
                            addTask(taskController.text);
                            taskController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  );
                },
              );
            },
            color: Colors.blue,
            child: const Text("Add Task"),
          ),
        ],
      ),
    );
  }
}
