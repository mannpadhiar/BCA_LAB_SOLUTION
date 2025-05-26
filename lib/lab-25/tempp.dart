import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model class for User
class User {
  final int? id;
  final String name;
  final String email;
  final String phone;

  User({this.id, required this.name, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

// API Service class
class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Get all users
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Insert new user
  static Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to create user');
    }
  }
}

// User List Screen
class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      List<User> fetchedUsers = await ApiService.getUsers();

      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Error loading users: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: loadUsers,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(child: Text('No users found'))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          User user = users[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.name[0].toUpperCase()),
              ),
              title: Text(user.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user.email}'),
                  Text('Phone: ${user.phone}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );

          if (result == true) {
            loadUsers(); // Refresh the list
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add User',
      ),
    );
  }
}

// Add User Screen
class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSubmitting = true;
    });

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Creating user...'),
          ],
        ),
      ),
    );

    try {
      User newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      // Simulate network delay
      await Future.delayed(Duration(seconds: 2));

      User createdUser = await ApiService.createUser(newUser);

      // Close progress dialog
      Navigator.pop(context);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User created successfully!'),
              SizedBox(height: 10),
              Text('Name: ${createdUser.name}'),
              Text('Email: ${createdUser.email}'),
              Text('Phone: ${createdUser.phone}'),
              if (createdUser.id != null) Text('ID: ${createdUser.id}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context, true); // Go back with success result
              },
              child: Text('OK'),
            ),
          ],
        ),
      );

    } catch (e) {
      // Close progress dialog
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to create user: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitForm,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Create User',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Main function
