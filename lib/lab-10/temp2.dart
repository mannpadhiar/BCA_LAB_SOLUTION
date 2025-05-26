import 'package:flutter/material.dart';

class Temp2 extends StatelessWidget {
  const Temp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('temp 2'),),
      body: Padding(  
        padding: const EdgeInsets.all(12.0),
        child: Text('This is temp 2!!'),
      ),
    );
  }
}
