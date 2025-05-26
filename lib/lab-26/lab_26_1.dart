import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Model
class User {
  final String id;
  final String name;
  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'name': name};
}

// Main Screen: List of Users
class UserListScreenEditDelete extends StatefulWidget {
  @override
  _UserListScreenEditDeleteState createState() => _UserListScreenEditDeleteState();
}

class _UserListScreenEditDeleteState extends State<UserListScreenEditDelete> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final res = await http.get(Uri.parse('https://6673d5f375872d0e0a93e612.mockapi.io/me/Dhruv/Users'));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body);
      setState(() {
        users = data.map((e) => User.fromJson(e)).toList();
      });
    }
  }

  Future<void> deleteUser(String id) async {
    bool confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm) {
      await http.delete(Uri.parse('https://6673d5f375872d0e0a93e612.mockapi.io/me/Dhruv/Users/$id'));
      fetchUsers(); // Refresh after delete
    }
  }

  Future<void> openForm({User? user}) async {
    bool? changed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserForm(user: user)),
    );
    if (changed == true) fetchUsers(); // Refresh after add/edit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, i) {
          final user = users[i];
          return ListTile(
            title: Text(user.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: () => openForm(user: user)),
                IconButton(icon: Icon(Icons.delete), onPressed: () => deleteUser(user.id)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}

// Add/Edit Form
class UserForm extends StatefulWidget {
  final User? user;
  UserForm({this.user});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  bool get isEdit => widget.user != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _nameController.text = widget.user!.name;
    }
  }

  Future<void> saveUser() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final userMap = {'name': name};

      final url = isEdit
          ? 'https://6673d5f375872d0e0a93e612.mockapi.io/me/Dhruv/Users/${widget.user!.id}'
          : 'https://6673d5f375872d0e0a93e612.mockapi.io/me/Dhruv/Users';

      final method = isEdit ? http.put : http.post;

      await method(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userMap),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit User" : "Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (val) => val == null || val.isEmpty ? "Name is required" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveUser,
                child: Text(isEdit ? "Update" : "Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}