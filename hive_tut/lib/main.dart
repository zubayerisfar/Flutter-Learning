import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hive_tut/pages/home_page.dart';

void main() async {
  
  await Hive.initFlutter();

  await Hive.openBox("database");

  runApp(const Hive_App());
}

class Hive_App extends StatelessWidget {
  const Hive_App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
