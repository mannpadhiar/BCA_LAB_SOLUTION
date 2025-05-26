import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User>? users;

  Future<void> loadUsers() async {
    final String jsonString = await rootBundle.loadString('assets/json_files/data.json');
    final dynamic jsonData = jsonDecode(jsonString);

    setState(() {
      if (jsonData is List) {
        users = jsonData.map((json) => User.fromJson(json)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        users = [User.fromJson(jsonData)];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Info')),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: users!.length,
          itemBuilder: (context, index) {
            final user = users![index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${user.name}'),
                    Text('Age: ${user.age}'),
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

class UserPageSingle extends StatefulWidget {
  const UserPageSingle({super.key});

  @override
  State<UserPageSingle> createState() => _UserPageSingleState();
}

class _UserPageSingleState extends State<UserPageSingle> {
  User? user;

  Future<void> loadUser() async {
    final String jsonString = await rootBundle.loadString('assets/json_files/data.json');
    final dynamic jsonData = jsonDecode(jsonString);

    setState(() {
      if (jsonData is List && jsonData.isNotEmpty) {
        user = User.fromJson(jsonData[0]);
      } else if (jsonData is Map<String, dynamic>) {
        user = User.fromJson(jsonData);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Info')),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user!.name}'),
            Text('Age: ${user!.age}'),
            Text('Email: ${user!.email}'),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final int age;
  final String email;

  User({
    required this.name,
    required this.age,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'email': email,
    };
  }
}