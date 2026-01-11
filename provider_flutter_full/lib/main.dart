import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_full/pages/page_1.dart';
import 'package:provider_flutter_full/providers/list_provider.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=>NumberListProvider())
      ],
      child: MaterialApp(
        home: Scaffold(
          body: FirstPage(),
        ),
      ),
    );
  }
}
