import 'package:flutter/material.dart';

import '../session.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userToken = null;
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
