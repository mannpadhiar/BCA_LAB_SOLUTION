import 'package:flutter/material.dart';
import 'package:flutterlabprograme/lab-10/temp.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Temp(),));
          }, child: Text('Navigation')),
        ),
      ),
    );
  }
}
