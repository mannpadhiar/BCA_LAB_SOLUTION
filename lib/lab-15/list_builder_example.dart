import 'package:flutter/material.dart';

class ListBuilderExample extends StatelessWidget {

  //List which we are going to display
  List<int> numbers = [4,5,8,2,3,0,6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: numbers.length,
        itemBuilder: (context, index) => ListTile(title: Text(numbers[index].toString()),),
      ),
    );
  }
}
