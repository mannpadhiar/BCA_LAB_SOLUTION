import 'package:flutter/material.dart';

class HorizontalPart extends StatelessWidget {
  const HorizontalPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //make a row with three thing
      body: Row(
        children: [

          //make container with expanded
          Expanded(child: Container(color: Colors.green,)),
          Expanded(child: Container(color: Colors.red,)),
          Expanded(child: Container(color: Colors.blue,))
        ],
      ),
    );
  }
}
