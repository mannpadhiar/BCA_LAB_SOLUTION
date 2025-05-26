import 'package:flutter/material.dart';

class ActionBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple ActionBar'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Menu 1',
                child: Text('Menu 1'),
              ),
            ],
            onSelected: (value) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Menu Clicked'),
                  content: Text('You clicked on: $value'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Click the menu in the top-right'),
      ),
    );
  }
}
