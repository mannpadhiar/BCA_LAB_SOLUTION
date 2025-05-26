import 'package:flutter/material.dart';

class VerticalPart extends StatelessWidget {
  const VerticalPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //column that show widgets in vertical form
      //so add three children in Column widget that make it vertical
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.green,)),
          Expanded(child: Container(color: Colors.red,)),
          Expanded(child: Container(color: Colors.blue,))
        ],
      ),
    );
  }
}
