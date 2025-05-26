import 'package:flutter/material.dart';

class ListExample extends StatelessWidget {

  List<int> numbers = [5,6,8,2,5,0,1];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(numbers[0].toString()),
          ),
          ListTile(
            title: Text(numbers[1].toString()),
          ),
          ListTile(
            title: Text(numbers[2].toString()),
          ),ListTile(
            title: Text(numbers[3].toString()),
          ),ListTile(
            title: Text(numbers[4].toString()),
          ),ListTile(
            title: Text(numbers[5].toString()),
          ),ListTile(
            title: Text(numbers[6].toString()),
          ),
        ],
      ),
    );
  }
}
