import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_full/providers/list_provider.dart';

class SecondPage extends StatefulWidget {

  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NumberListProvider>(
          builder: (context, provider, child) {
            return Text('The Last Number is ${provider.numbers.last}');
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<NumberListProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.numbers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Number: ${provider.numbers[index]}'),
                    );
                  },
                );
              },
            ),
          ),
          Consumer<NumberListProvider>(
            builder: (context, provider, child) {
              return FloatingActionButton(
                onPressed: () {
                  provider.addNumber();
                },
                child: child,
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
