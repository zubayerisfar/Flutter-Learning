import "package:flutter/material.dart";
import "package:form_and_everything/pages/custom_form_field.dart";
import "package:form_and_everything/pages/extensions.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomFormField(
                labeltext: "Name",
                obsecuretext: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              CustomFormField(
                labeltext: "Email",
                obsecuretext: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  } else if (!value.validEmail) {
                    return "Please enter valid email";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              CustomFormField(
                labeltext: "Password",
                obsecuretext: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  } else if (!value.validPassword) {
                    return "Password must be at least 8 characters long and contain at least one letter and one number";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("$_name $_email $_password");
                  }
                },
                child: Text("Validate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
