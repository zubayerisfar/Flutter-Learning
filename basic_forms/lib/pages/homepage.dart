import 'package:basic_forms/pages/customform.dart';
import 'package:flutter/material.dart';
import 'package:basic_forms/pages/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Creation Practice")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  labelText: "Name",
                  obsecuretText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null; // if no error occured then returns simple null value
                  },
                  onSaved: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                CustomFormField(
                  labelText: "Email",
                  obsecuretText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    } else if (!value.validEmail) {
                      return "Enter a valid email!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                CustomFormField(
                  labelText: "Password",
                  obsecuretText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    } else if (!value.validPassword) {
                      return "Enter a valid password!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print("Name : $name , Email : $email , Password : $password");
                    }
                  },
                  color: Colors.blue,
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
