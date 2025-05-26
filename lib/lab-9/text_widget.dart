import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //text widget with a hello world string in it
          Text('Hello World',style: TextStyle(color: Colors.blue,fontSize: 34,fontWeight: FontWeight.w600),),

          //custom text widget that is defined below
          customText('hello'),
        ],
      ),
    );
  }

  //this is a custom widget with a return of a text in it
  Widget customText(String msg){
    return Text(msg,style: TextStyle(color: Colors.green,fontFamily: 'Poppins',fontSize: 20),);
  }
}
