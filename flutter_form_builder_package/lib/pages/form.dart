import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
// EDIT: Added import for HomePage to navigate to it after form submission
import 'homepage.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Form")),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "Name",
                  decoration: InputDecoration(label: Text("Enter your name")),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    // EDIT: Changed from max(100) to maxLength(100) for s
                    //t3ring validation
                    FormBuilderValidators.maxLength(100),
                  ]),
                ),
                SizedBox(height: 20),
                FormBuilderDropdown(
                  name: "Choose your gender",
                  items: [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                  ],
                ),
                SizedBox(height: 20),
                FormBuilderCheckbox(name: 'isGay', title: Text("Not Gay")),
                SizedBox(height: 20),
                FormBuilderDateTimePicker(
                  name: "BirthDate",
                  inputType: InputType.date,
                  decoration: InputDecoration(
                    label: Text("Select your birth date"),
                  ),
                ),
                SizedBox(height: 20),
                FormBuilderRadioGroup(
                  name: "Radio",
                  orientation: OptionsOrientation.vertical,
                  wrapDirection: Axis
                      .horizontal, // if there are many options, they will wrap
                  options: [
                    FormBuilderFieldOption(
                      value: "Option 1",
                      child: Text("Option 1"),
                    ),
                    FormBuilderFieldOption(
                      value: "Option 2",
                      child: Text("Option 2"),
                    ),
                  ],
                ),
                // EDIT: Added SizedBox for spacing before submit button
                SizedBox(height: 30),
                // EDIT: Added Submit button that validates and navigates to HomePage
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      // EDIT: Get form data after validation
                      final formData = _formKey.currentState!.value;
                      // EDIT: Navigate to HomePage with form data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(formData: formData),
                        ),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
