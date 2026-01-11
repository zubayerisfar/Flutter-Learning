import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/pages/settings.dart';
import 'package:provider_flutter/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text("Provider Tutorial"),
          ),
          body: Center(
            child: Text(context.watch<UserProvider>().username),
          ),
          bottomNavigationBar: BottomNavigationBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings",),
          ],
          onTap: (index){
            if(index == 1){
              MaterialPageRoute route = MaterialPageRoute(builder: (context) => Settings());
              Navigator.push(context, route);
            }
          }
          )
          ,
        );
  }
}