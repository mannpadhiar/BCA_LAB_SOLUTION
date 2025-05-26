import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ListPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> items = ['Apple', 'Banana', 'Orange'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Page')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(items[index]),
          onTap: () async {
            // Navigate to detail page and wait for result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(item: items[index]),
              ),
            );

            // If result is not null, update list
            if (result != null) {
              setState(() {
                items[index] = result;
              });
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String item;
  final TextEditingController itemController;

  //Initializer list explain this concept!
  DetailPage({required this.item}) : itemController = TextEditingController(text: item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: InputDecoration(labelText: 'Edit Item'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return edited value to previous page
                Navigator.pop(context, itemController.text);
              },
              child: Text('Save & Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
