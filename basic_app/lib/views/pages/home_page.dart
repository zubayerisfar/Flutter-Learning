import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 400,
        margin: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 248, 232, 0)
        ),
        child: Center(
          child: Text(
            'Home Page',
            style:TextStyle(
              color: Colors.black,
              fontSize: 24,
            )            
          ),
        ),
      ),
    );
  }
}