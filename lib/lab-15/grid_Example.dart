import 'package:flutter/material.dart';

class GridExample extends StatelessWidget {

  List<String> imagePaths = ['https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200','https://picsum.photos/200'];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    //using GridView.builder
      return Scaffold(
        body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => Image.network(imagePaths[index]),),
      );
    //Using Gridview
    // return Scaffold(
    //   body: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //   children: [
    //     Image.network(imagePaths[0]),
    //     Image.network(imagePaths[1]),
    //     Image.network(imagePaths[2]),
    //     Image.network(imagePaths[3]),
    //   ],
    //   )
    // );
  }
}
