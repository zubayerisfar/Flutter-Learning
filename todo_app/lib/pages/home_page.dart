import 'package:flutter/material.dart';
import 'package:todo_app/pages/dialog_box.dart';
import 'package:todo_app/pages/todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todoList = [
    ["Buy groceries", false],
    ["Walk the dog", true],
    ["Read a book", false],
  ];

  void checkboxStateChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = value;  // flutter returns a nullable boolean which is why we use bool? and set it to value
      // another option to do so todoList[index][1] = !todoList[index][1];reverse the boolean value meaning set true to false and false to true
    });
  }

  void addTask() {
    // open dialog to add task
    showDialog(context: context, builder: (context) {
      return DialogBox();
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 184),
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Colors.amber,
      ),
      body:ListView.builder(itemCount: todoList.length,
      itemBuilder: (context, index) {
        return TodoTile(todoText: todoList[index][0], 
        isChecked: todoList[index][1],
        onChanged: (value) => checkboxStateChanged(value, index), 
        );
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.add),
      ),
    );  
  }
}