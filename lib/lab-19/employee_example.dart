import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(home: EmployeeEntryScreen(),));
}

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'employee.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Employee(
          EmpID INTEGER PRIMARY KEY AUTOINCREMENT,
          Name TEXT, DOB TEXT, City TEXT, Address TEXT,
          Contact TEXT, Email TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE EmpDepartment(
          DeptID INTEGER PRIMARY KEY AUTOINCREMENT,
          EmpID INTEGER,
          DeptName TEXT,
          Designation TEXT,
          DateOfJoining TEXT
        )
      ''');
    });
  }

  static Future<int> insertEmployee(Map<String, dynamic> data) async {
    final dbClient = await db;
    return await dbClient.insert('Employee', data);
  }

  static Future<void> insertDepartment(Map<String, dynamic> data) async {
    final dbClient = await db;
    await dbClient.insert('EmpDepartment', data);
  }

  static Future<List<Map<String, dynamic>>> getAllEmployees() async {
    final dbClient = await db;
    return await dbClient.rawQuery('''
      SELECT e.EmpID, Name, DOB, City, Address, Contact, Email,
             DeptName, Designation, DateOfJoining
      FROM Employee e
      LEFT JOIN EmpDepartment d ON e.EmpID = d.EmpID
    ''');
  }

  static Future<void> updateEmployee(int id, Map<String, dynamic> data) async {
    final dbClient = await db;
    await dbClient.update('Employee', data, where: 'EmpID=?', whereArgs: [id]);
  }

  static Future<void> deleteEmployee(int id) async {
    final dbClient = await db;
    await dbClient.delete('EmpDepartment', where: 'EmpID=?', whereArgs: [id]);
    await dbClient.delete('Employee', where: 'EmpID=?', whereArgs: [id]);
  }
}

class EmployeeEntryScreen extends StatefulWidget {
  @override
  _EmployeeEntryScreenState createState() => _EmployeeEntryScreenState();
}

class _EmployeeEntryScreenState extends State<EmployeeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController contact = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController dept = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController doj = TextEditingController();

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      int empId = await DBHelper.insertEmployee({
        'Name': name.text,
        'DOB': dob.text,
        'City': city.text,
        'Address': address.text,
        'Contact': contact.text,
        'Email': email.text
      });

      await DBHelper.insertDepartment({
        'EmpID': empId,
        'DeptName': dept.text,
        'Designation': designation.text,
        'DateOfJoining': doj.text
      });

      // Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeListScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Entry')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: name, decoration: InputDecoration(labelText: 'Name')),
            TextFormField(controller: dob, decoration: InputDecoration(labelText: 'DOB')),
            TextFormField(controller: city, decoration: InputDecoration(labelText: 'City')),
            TextFormField(controller: address, decoration: InputDecoration(labelText: 'Address')),
            TextFormField(controller: contact, decoration: InputDecoration(labelText: 'Contact')),
            TextFormField(controller: email, decoration: InputDecoration(labelText: 'Email')),
            Divider(),
            TextFormField(controller: dept, decoration: InputDecoration(labelText: 'Department')),
            TextFormField(controller: designation, decoration: InputDecoration(labelText: 'Designation')),
            TextFormField(controller: doj, decoration: InputDecoration(labelText: 'Date of Joining')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveData, child: Text('Save')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeListScreen()));
                },
                child: Text('View All'))
          ]),
        ),
      ),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Map<String, dynamic>> data = [];

  void _loadData() async {
    final result = await DBHelper.getAllEmployees();
    setState(() {
      data = result;
    });
  }

  void _delete(int id) async {
    await DBHelper.deleteEmployee(id);
    _loadData();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Records')),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, i) {
          final item = data[i];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(item['Name']),
              subtitle: Text('${item['DeptName']} | ${item['Designation']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: Icon(Icons.delete), onPressed: () => _delete(item['EmpID'])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
