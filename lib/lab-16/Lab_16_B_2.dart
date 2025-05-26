import 'package:flutter/material.dart';

class PassDataWithConstuctorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String message = "Hello from HomePage!";

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Pass data to SecondPage using constructor
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondPage(data: message),
              ),
            );
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String data; // Receive data using constructor

  SecondPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Center(
        child: Text(
          data,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
