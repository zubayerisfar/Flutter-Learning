import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/pages/homepage.dart';
import 'package:provider_flutter/providers/user_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
      [
        ChangeNotifierProvider(create:(context) => UserProvider(), )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
      );
  }
}
