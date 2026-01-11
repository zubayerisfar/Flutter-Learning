import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textFieldController =
      TextEditingController(); // Controller for the text field
  final database = Hive.box(
    "mydb",
  ); // Accessing the opened Hive database (which is named "mydb" here)
  List task_list = []; // This will hold the list of tasks
  @override
  void initState() {
    super.initState();
    // You can perform any initializations related to the database here if needed
    task_list =
        database.get("TASKS") ??
        []; // Retrieving the list of tasks from the database
  }

  void add_task(String task) {
    setState(() {
      task_list.add(task);
      database.put(
        "TASKS",
        task_list,
      ); // Updating the database with the new task list
    });
  }

  void delete_task(int index) {
    setState(() {
      task_list.removeAt(index);
      database.put(
        "TASKS",
        task_list,
      ); // Updating the database after deleting the task
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: task_list.isEmpty
          ? Center(
              child: Text("No Tasks Added", style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: task_list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(task_list[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      delete_task(index);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add New Task"),
                    content: TextField(controller: _textFieldController),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          add_task(_textFieldController.text);
                          _textFieldController.clear();
                        },
                        child: Text("Add"),
                      ),
                    ],
                  );
                },
              );
            },
            color: Colors.blue,
            child: Text("Add Task"),
          ),
        ],
      ),
    );
  }
}
