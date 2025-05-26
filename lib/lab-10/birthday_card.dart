import 'package:flutter/material.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('BirthDay'),),
      body: Stack(
        children: [
          Image.network('https://d1csarkz8obe9u.cloudfront.net/posterpreviews/ballon-background-happy-birthday-card-design-template-215b737d725b153a0563f9fa6dd174a6_screen.jpg?ts=1684826335'),
          Padding(
            padding: const EdgeInsets.only(top: 300,left: 135),
            child: Text('Mann',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
          ),
        ],
      ),
    );
  }
}
