import 'package:flutter/material.dart';
import 'package:flutterlabprograme/lab-10/temp.dart';
import 'package:flutterlabprograme/lab-10/temp2.dart';


class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final pages = [Temp(),Temp2()];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.green,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'home',backgroundColor: Colors.teal,tooltip: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Person',backgroundColor: Colors.yellow),
      ]),
      body: pages[selectedIndex],
    );
  }
}
