import 'package:flutter/material.dart';

class Lab223 extends StatefulWidget {
  const Lab223({super.key});

  @override
  State<Lab223> createState() => _Lab223State();
}

class _Lab223State extends State<Lab223> {

  DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DatePicker'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () async{
              date = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDate: date,
              );
              setState(() {});
            }, child: Text('Select Date')),
            Text(date.toString()),
          ],
        ),
      ),
    );
  }
}
