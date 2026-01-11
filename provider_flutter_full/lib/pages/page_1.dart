import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_full/pages/page_2.dart';
import 'package:provider_flutter_full/providers/list_provider.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
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
          FloatingActionButton(
            heroTag: 'navigate',
            child: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SecondPage(),
                ),
              );
            },
          ),
          FloatingActionButton(
            heroTag: 'add',
            child: Icon(Icons.add),
            onPressed: () {
              context.read<NumberListProvider>().addNumber();
            },
          ),
        ],
      ),
    );
  }
}
