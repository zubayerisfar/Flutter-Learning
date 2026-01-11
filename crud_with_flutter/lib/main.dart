import 'package:crud_with_flutter/pages/crud_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  var response =await BaseClient().get_user("users").catchError((err){});
                  if (response != null) {
                    debugPrint(response);
                  }
                },
                color: Colors.green,
                child: Text("GET"),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text("POST"),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.orange,
                child: Text("PUT"),
              ),
              MaterialButton(
                onPressed: () {},
                color: Colors.red,
                child: Text("DELETE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
