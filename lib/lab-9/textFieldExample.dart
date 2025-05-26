import 'package:flutter/material.dart';
import 'dart:io';

class TextFieldExample extends StatefulWidget {
  const TextFieldExample({super.key});

  @override
  State<TextFieldExample> createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {

  //textEditingController which has control of a textField
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            //this is a text field with a controller of TextEditingController so that value of a textField save in that
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                label: Text('Name'),
                // hintText: 'Enter your name',
              ),
            ),
          ),
          SizedBox(height: 40,),

          //on the press of a button the value of textField should be print on a console
          ElevatedButton(onPressed: () {
            print(textEditingController.text);
          }, child: Text('Print')),
        ],
      ),
    );
  }
}
