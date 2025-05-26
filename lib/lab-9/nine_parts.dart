import 'package:flutter/material.dart';

class NineParts extends StatefulWidget {
  const NineParts({super.key});

  @override
  State<NineParts> createState() => _NinePartsState();
}

class _NinePartsState extends State<NineParts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //make a row with a column which has three children
      body: Row(
        children: [
          Expanded(
            //first column
            child: Column(
              children: [
                Expanded(flex: 2,child: Container(color: Colors.green,)),
                Expanded(child: Container(color: Colors.red,)),
                Expanded(child: Container(color: Colors.blue,))
              ],
            ),
          ),
          Expanded(
            //second column
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.orange,)),
                Expanded(flex: 3,child: Container(color: Colors.yellow,)),
                Expanded(child: Container(color: Colors.lime,))
              ],
            ),
          ),
          Expanded(
            //third column
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.brown,)),
                Expanded(child: Container(color: Colors.teal,)),
                Expanded(flex: 2,child: Container(color: Colors.black,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
