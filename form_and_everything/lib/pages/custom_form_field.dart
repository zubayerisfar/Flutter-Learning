import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {

  final String labeltext;
  final bool obsecuretext;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;

  const CustomFormField({super.key, required this.labeltext, required this.obsecuretext, required this.validator, required this.onSaved});

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(labeltext), 
        
        ),
        obscureText: obsecuretext,
        validator: validator, 
        onSaved: onSaved,
      ),
    
      
    );
  }
}