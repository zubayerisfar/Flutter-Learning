import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String labelText;
  final bool obsecuretText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const CustomFormField({super.key, required this.labelText, required this.obsecuretText, required this.validator, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        obscureText: obsecuretText,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
