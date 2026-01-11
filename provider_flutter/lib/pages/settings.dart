import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/providers/user_provider.dart';

class Settings extends StatelessWidget {

  final TextEditingController textcontroller = TextEditingController();

  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "Enter new username",
          ),
          controller: textcontroller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserProvider>().changeUsername(newUsername: textcontroller.text);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}