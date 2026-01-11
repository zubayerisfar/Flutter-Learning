import 'package:flutter/material.dart';
import 'package:navbar_practice/pages/home_page.dart';
import 'package:navbar_practice/pages/second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  

  final List<Widget> _pages = [
    HomePage(),
    SecondPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NavBar Demo"),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 170, 197, 219),
          child:Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.person,
                  size: 100,
                ) 
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home Page"),
                onTap: (){
                  // pop the drawer first
                  Navigator.pop(context);
                  // then navigate to first page
                  Navigator.pushNamed(context, "/home");
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Second Page"),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/second");
                },
              )
            ],
          ) 
        ),
        body: _pages[_selectedIndex],

        bottomNavigationBar:BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Second"),

          ] ),
      );
  }
}