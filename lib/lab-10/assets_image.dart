import 'package:flutter/material.dart';

class AssetsImage extends StatelessWidget {
  const AssetsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //make a asset folder which has all image in it and add the path of it in assets in pubspec.yaml file ans perform pub get
          //add that path of a image a=with the image name in Image.asset()
          Image.asset('assets/images/image1.jpg'),
        ],
      ),
    );
  }
}
