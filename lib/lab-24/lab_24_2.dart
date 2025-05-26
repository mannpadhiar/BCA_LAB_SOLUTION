import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: EasyUserForm()));

class EasyUserForm extends StatefulWidget {
  @override
  _EasyUserFormState createState() => _EasyUserFormState();
}

class _EasyUserFormState extends State<EasyUserForm> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://6831531a6205ab0d6c3be6ed.mockapi.io/users');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'name': nameCtrl.text,
          'dob': dobCtrl.text,
          'city': cityCtrl.text,
          'address': addressCtrl.text,
          'email': emailCtrl.text,
        },
      );

      if (response.statusCode == 201) {
        print('data submitted successfully');
        _formKey.currentState!.reset();
      } else {
        print('failed to submit data');
      }
    }
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobCtrl.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Entry Form')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                value!.isEmpty ? 'Enter your name' : null,
              ),
              // DOB
              TextFormField(
                controller: dobCtrl,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onTap: pickDate,
                validator: (value) =>
                value!.isEmpty ? 'Pick a date' : null,
              ),
              // City
              TextFormField(
                controller: cityCtrl,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) =>
                value!.isEmpty ? 'Enter your city' : null,
              ),
              // Address
              TextFormField(
                controller: addressCtrl,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                value!.isEmpty ? 'Enter your address' : null,
              ),
              // Email
              TextFormField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter email';
                  final emailRegex =
                  RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
                  if (!emailRegex.hasMatch(value)) return 'Invalid email';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
