import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: RegistrationForm()));

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String? gender;
  bool hobbyReading = false;
  bool hobbyMusic = false;
  bool hobbyTimePass = false;

  // Date Picker
  void _selectDOB() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dob.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _resetForm() {
    firstName.clear();
    lastName.clear();
    email.clear();
    mobile.clear();
    city.clear();
    dob.clear();
    password.clear();
    confirmPassword.clear();
    gender = null;
    hobbyReading = false;
    hobbyMusic = false;
    hobbyTimePass = false;
    _formKey.currentState!.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('First Name'),
              TextFormField(
                controller: firstName,
                validator: (value) =>
                value!.isEmpty ? "Enter first name" : null,
              ),

              Text('Last Name'),
              TextFormField(
                controller: lastName,
                validator: (value) =>
                value!.isEmpty ? "Enter last name" : null,
              ),

              Text('Email'),
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }
                  if (!value.contains("@")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              Text('Number'),
              TextFormField(
                controller: mobile,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter mobile number";
                  }
                  if (value.length != 10) {
                    return "Mobile number must be 10 digits";
                  }
                  return null;
                },
              ),

              Text('City'),
              TextFormField(
                controller: city,
                validator: (value) => value!.isEmpty ? "Enter city" : null,
              ),

              SizedBox(height: 10),

              Text("Gender:", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Radio<String>(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                  ),
                  Text("Male"),
                  Radio<String>(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              if (gender == null)
                Text("Please select gender", style: TextStyle(color: Colors.red)),

              Text('Date of birth'),
              TextFormField(
                controller: dob,
                readOnly: true,
                onTap: _selectDOB,
                validator: (value) {
                  value!.isEmpty ? "Select date of birth" : null;
                }
              ),

              SizedBox(height: 10),
              Text("Hobbies:", style: TextStyle(fontSize: 16)),
              CheckboxListTile(
                title: Text("Reading"),
                value: hobbyReading,
                onChanged: (value) {
                  setState(() {
                    hobbyReading = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Music"),
                value: hobbyMusic,
                onChanged: (value) {
                  setState(() {
                    hobbyMusic = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Time Pass"),
                value: hobbyTimePass,
                onChanged: (value) {
                  setState(() {
                    hobbyTimePass = value!;
                  });
                },
              ),

              Text('Password'),
              TextFormField(
                controller: password,
                obscureText: true,
                validator: (value) =>
                value!.isEmpty ? "Enter password" : null,
              ),

              Text('Confirm Password'),
              TextFormField(
                controller: confirmPassword,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return "Enter confirm password";
                  if (value != password.text) return "Passwords do not match";
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && gender != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Form Submitted")),
                        );
                        print(firstName.text);
                        print(lastName.text);
                        print(email.text);
                        print(mobile.text);
                        print(city.text);
                        print(gender);
                        print(dob.text);
                        print(hobbyMusic);
                        print(hobbyReading);
                        print(hobbyTimePass);
                        print(password.text);
                        print(confirmPassword.text);
                      }
                    },
                    child: Text("Save"),
                  ),
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: _resetForm,
                    child: Text("Reset"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
