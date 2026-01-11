import 'package:basic_app/views/data/notifiers.dart';
import 'package:basic_app/views/pages/home_page.dart';
import 'package:basic_app/views/pages/profile_page.dart';
import 'package:basic_app/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

List<Widget> pages =[
  HomePage(),
  ProfilePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('My Flutter App'),
        actions: [
          IconButton(
            icon: 
            ValueListenableBuilder(valueListenable: isDarkModeNotifier, builder: (context, value, child) {
              return Icon(value == 0 ? Icons.dark_mode : Icons.light_mode);
            },),
            onPressed: () {
              // Action for settings button
              isDarkModeNotifier.value = isDarkModeNotifier.value == 0 ? 1 : 0;
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(valueListenable: selectedPageNotifier, builder: (context, selectedPage, child){
        return pages[selectedPage];
      },),
      bottomNavigationBar: NavbarWidget()
    );
  }
}