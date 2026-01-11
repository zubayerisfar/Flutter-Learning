import 'package:flutter/material.dart';
import 'package:flutter_application_2/home_page.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter(); // This will initialize the Hive database

  await Hive.openBox("mydb"); // This will locate and open the stored database

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
