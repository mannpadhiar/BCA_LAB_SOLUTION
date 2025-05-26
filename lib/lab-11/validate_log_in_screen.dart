import 'package:flutter/material.dart';

class ValidateLogInScreen extends StatefulWidget {
  const ValidateLogInScreen({super.key});

  @override
  State<ValidateLogInScreen> createState() => _ValidateLogInScreenState();
}

class _ValidateLogInScreenState extends State<ValidateLogInScreen> {

  final formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isValidEmail(String value){
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  bool isValidPassword(String value){
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log-In'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Enter a valid email';
                    }
                  },
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Enter a valid email';
                    }
                  },
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
                  if(formKey.currentState!.validate()){
                    print('you loged in');
                  }else{
                    print('something went wrong');
                  }
                }, child: Text('LogIn')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
