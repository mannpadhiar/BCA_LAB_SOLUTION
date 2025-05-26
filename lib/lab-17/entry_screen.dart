  import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EmployeeApp extends StatefulWidget {
  @override
  State<EmployeeApp> createState() => _EmployeeAppState();
}

class _EmployeeAppState extends State<EmployeeApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<Map<String, dynamic>> employees = [];
  late Database db;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  //to initializing database
  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'employee.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE employee (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT
          )
        ''');
      },
    );

    loadEmployees();
  }

  //To add data in table
  Future<void> addEmployee(String name, String address) async {
    await db.insert('employee', {'name': name, 'address': address});
    loadEmployees();
  }

  //To fetch data from database
  Future<void> loadEmployees() async {
    final data = await db.query('employee');
    setState(() {
      employees = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                String address = addressController.text.trim();
                if (name.isNotEmpty && address.isNotEmpty) {
                  addEmployee(name, address);
                  nameController.clear();
                  addressController.clear();
                }
              },
              child: Text('Save'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(employees[index]['name']),
                    subtitle: Text(employees[index]['address']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
