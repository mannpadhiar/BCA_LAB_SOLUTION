import 'package:flutter/material.dart';

class ListMapExample extends StatelessWidget {
   ListMapExample({super.key});

  final List<Map<String, dynamic>> users = [
    {
      'name': 'John',
      'surname': 'Doe',
      'birthdate': '1990-01-15',
      'city': 'New York',
    },
    {
      'name': 'Emma',
      'surname': 'Watson',
      'birthdate': '1992-04-15',
      'city': 'London',
    },
    {
      'name': 'Raj',
      'surname': 'Kumar',
      'birthdate': '1988-09-12',
      'city': 'Mumbai',
    },
    {
      'name': 'Sophia',
      'surname': 'Lee',
      'birthdate': '1995-11-30',
      'city': 'Seoul',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text('${user['name']} ${user['surname']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Birthdate: ${user['birthdate']}'),
                  Text('City: ${user['city']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

