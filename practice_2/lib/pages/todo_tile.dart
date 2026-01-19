import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final bool isChecked;
  final String taskName;
  final Function(bool?)? onChanged;
  const TodoTile({super.key, required this.isChecked, required this.taskName, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 181, 70),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(value: isChecked, onChanged: onChanged),
          const SizedBox(width: 8),
          Text(taskName,
              style: TextStyle(
                  decoration:
                      isChecked ? TextDecoration.lineThrough : null)),
        ],
      ),
    );
  }
}
