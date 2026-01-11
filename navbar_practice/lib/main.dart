import 'package:flutter/material.dart';
import 'package:navbar_practice/pages/first_page.dart';
import 'package:navbar_practice/pages/home_page.dart';
import 'package:navbar_practice/pages/second_page.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/second': (context) => SecondPage(), 
      },
    );
  }
}