import 'package:flutter/material.dart';

class StackImage extends StatelessWidget {
  const StackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/images/image1.jpg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Hello',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
