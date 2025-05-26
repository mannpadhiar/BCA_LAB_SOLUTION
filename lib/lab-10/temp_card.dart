import 'package:flutter/material.dart';

class TempCard extends StatelessWidget {
  final String name;
  const TempCard({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network('https://d1csarkz8obe9u.cloudfront.net/posterpreviews/ballon-background-happy-birthday-card-design-template-215b737d725b153a0563f9fa6dd174a6_screen.jpg?ts=1684826335'),
          Padding(
            padding: const EdgeInsets.only(top: 300,left: 135),
            child: Text(name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
          ),
        ],
      ),
    );
  }
}
