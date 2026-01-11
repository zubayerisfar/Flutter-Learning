

import 'package:flutter/material.dart';

class NumberListProvider extends ChangeNotifier{
  List<int> numbers = [1,2,3,4,5];

  void addNumber(){
    numbers.add(numbers.length + 1);
    notifyListeners();
  }
}