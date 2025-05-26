import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lab224 extends StatefulWidget {
  const Lab224({super.key});

  @override
  State<Lab224> createState() => _Lab224State();
}

class _Lab224State extends State<Lab224> {

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  List users = [];

  Future<void> loadJsonData() async{
    final String jsonString = await rootBundle.loadString('assets/json_files/data.json');
    final data = jsonDecode(jsonString);
    print(data);
    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Json Data"),),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(users[index]['name']),
          subtitle: Text(users[index]['number'].toString()),
        ),
      )
    );
  }
}
