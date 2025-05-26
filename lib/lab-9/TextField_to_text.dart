import 'package:flutter/material.dart';

class TextFieldToText extends StatefulWidget {
  const TextFieldToText({super.key});

  @override
  State<TextFieldToText> createState() => _TextFieldToTextState();
}

class _TextFieldToTextState extends State<TextFieldToText> {

  //textEditingController which has control of a textField
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          //this is a text field with a controller of TextEditingController so that value of a textField save in that
          Padding(
            padding: const EdgeInsets.all(8.0),
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

          //on the click of a button perform setState so that the ui rebuild and the text below that will show
          ElevatedButton(onPressed: () {
            setState(() {});
            print(textEditingController.text);
          }, child: Text('Print')),

          //before pressing the button controller has none value and after the button press controller has value of a textField
          Text(textEditingController.text),
        ],
      ),
    );
  }
}
