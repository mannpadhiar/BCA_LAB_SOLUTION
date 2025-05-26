import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lab222 extends StatefulWidget {
  const Lab222({super.key});

  @override
  State<Lab222> createState() => _Lab222State();
}

class _Lab222State extends State<Lab222> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cupertino Alert'),),
      body: Center(
        child: ElevatedButton(onPressed: () {
          showCupertinoDialog(context: context, builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Are you sure!!!'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  isDestructiveAction: true,
                  child: const Text('Delete'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  isDefaultAction: true,
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
    }, child: Text('Show Dialog')),
    ),
    );
  }
}
