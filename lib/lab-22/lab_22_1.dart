import 'package:flutter/material.dart';

class Lab221 extends StatefulWidget {
  const Lab221({super.key});

  @override
  State<Lab221> createState() => _Lab221State();
}

class _Lab221State extends State<Lab221> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alert Dialog'),),
      body: Center(
        child: ElevatedButton(onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Are you sure!!!'),
              icon: Icon(Icons.e_mobiledata),
              actions: [
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pop();
                  print(1);
                }, child: Text('Ok'))
              ],
            );
          },);
        }, child: Text('Show Dialog')),
      ),
    );
  }
}
