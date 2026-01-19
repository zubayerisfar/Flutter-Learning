import 'package:flutter/material.dart';
import 'package:practice_2/pages/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todoList = [
    ["Buy groceries", false],
    ["Walk the dog", true],
    ["Read a book", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Todo Page')),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              isChecked: todoList[index][1],
              taskName: todoList[index][0],
              onChanged: (bool? value) {
                checkBoxChanged(value, index);
              },
            );
          },
        ),
      ),
    );
  }
}