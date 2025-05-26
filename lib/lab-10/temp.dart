import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  const Temp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temp'),),
      body: SafeArea(child: Text('Hello!!!!!!!!',style: TextStyle(fontSize: 24),)),
    );
  }
}
