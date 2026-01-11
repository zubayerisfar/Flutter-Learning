import 'package:flutter/material.dart';


class TodoTile extends StatelessWidget {
  final bool isChecked;
  final String todoText ;
  final Function(bool?)? onChanged;

  const TodoTile({
    super.key,
    required this.todoText,
    required this.onChanged,
    required this.isChecked,
    } );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: Row(
        children: [
          Checkbox(value: isChecked, onChanged: onChanged),
          Expanded( // GPT suggested to use Expanded to avoid overflow error and make it fit to the screen
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color:  const Color.fromARGB(255, 250, 218, 34),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(todoText, style: TextStyle(
                decoration: isChecked 
                ? TextDecoration.lineThrough 
                : null,  // condition ? true case : false cases
              ),),
            ),
          ),
        ],
      ),
    );
  }
}