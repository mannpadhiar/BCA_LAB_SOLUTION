import 'package:flutter/material.dart';
import 'package:flutterlabprograme/lab-10/temp.dart';

class NamedNavigation extends StatelessWidget {
  const NamedNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/temp');
            }, child: Text('Go to temp')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/temp2');
            }, child: Text('Go to temp2')),
          ],
        )
      ),
    );
  }
}
