import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration'),),
      body: Column(
        children: [
          Row(
            children: [
              Text('First name :'),
              TextField()
            ],
          ),
          Row(
            children: [
              Text('Last name :'),
              TextField()
            ],
          ),
          Row(
            children: [
              Text('Email :'),
              TextField()
            ],
          ),
          Row(
            children: [
              Text('Mobile Number :'),
              TextField()
            ],
          ),
        ],
      ),
    );
  }
}
