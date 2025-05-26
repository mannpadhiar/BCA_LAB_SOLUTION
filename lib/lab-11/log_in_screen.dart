import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log-In'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                controller: username,
              ),
            ),
            SizedBox(height: 20,),

            Text('Password'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                controller: password,
              ),
            ),
            SizedBox(height: 20,),

            Center(
              child: ElevatedButton(onPressed: () {
                print('you loged in');
              }, child: Text('LogIn')),
            ),
          ],
        ),
      ),
    );
  }
}
