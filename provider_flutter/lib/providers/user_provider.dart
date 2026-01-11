import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  String username;

  UserProvider({
    this.username ="Guest",
  });

  void changeUsername( {required String newUsername}) async {
    username = newUsername;
    notifyListeners();
  }
}