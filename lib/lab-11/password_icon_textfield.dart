import 'package:flutter/material.dart';

class PasswordIconTextField extends StatefulWidget {
  const PasswordIconTextField({super.key});

  @override
  State<PasswordIconTextField> createState() => _PasswordIconTextFieldState();
}

class _PasswordIconTextFieldState extends State<PasswordIconTextField> {

  bool isObText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('name'),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              obscureText: isObText,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(onPressed: () {
                  setState(() {
                    isObText = !isObText;
                  });
                }, icon: isObText?Icon(Icons.remove_red_eye_outlined):Icon(Icons.remove_red_eye)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
