import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi_learn_1/models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<GetModel> getModels = [];

  Future<List<GetModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        getModels.add(GetModel.fromJson(i));
      }
      return getModels;
    } else {
      return getModels;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('HTTP Example')),
        body: Column(
          children: [
            FutureBuilder<List<GetModel>>(
              future: getData(),
              builder: (context,AsyncSnapshot<List<GetModel>> result) {
                if (!result.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(
                                result.data![index].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(result.data![index].body),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
