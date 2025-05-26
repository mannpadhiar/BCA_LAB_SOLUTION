import 'package:flutter/material.dart';

// UserModel class
class UserModel {
  final String name;
  final String surname;
  final String birthdate;
  final String city;

  UserModel({
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.city,
  });
}

class UserGridScreen extends StatelessWidget {
  // List of users
  final List<UserModel> users = [
    UserModel(name: 'Rajesh', surname: 'Doe', birthdate: '1990-01-15', city: 'New York'),
    UserModel(name: 'Dhruv', surname: 'Watson', birthdate: '1992-04-15', city: 'London'),
    UserModel(name: 'Raj', surname: 'Kumar', birthdate: '1988-09-12', city: 'Mumbai'),
    UserModel(name: 'Sophia', surname: 'Lee', birthdate: '1995-11-30', city: 'Seoul'),
    UserModel(name: 'Hella', surname: 'Reza', birthdate: '1985-07-23', city: 'Tehran'),
    UserModel(name: 'Thor', surname: 'Gomez', birthdate: '1991-03-10', city: 'Madrid'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Grid')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: users.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.name} ${user.surname}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Birthdate: ${user.birthdate}'),
                    Text('City: ${user.city}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
