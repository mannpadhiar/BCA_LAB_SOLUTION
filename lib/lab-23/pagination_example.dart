import 'package:flutter/material.dart';

class SimplePaginationScreen extends StatefulWidget {
  @override
  _SimplePaginationScreenState createState() => _SimplePaginationScreenState();
}

class _SimplePaginationScreenState extends State<SimplePaginationScreen> {
  List<String> items = [];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadItems(); // Load first batch

    // Listen to scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        loadItems(); // Load more when reached bottom
      } 
    });
  }

  Future<void> loadItems() async {
    if (isLoading) return; // Prevent multiple calls

    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 1));

    // Add 10 new items
    List<String> newItems = [];
    for (int i = items.length + 1; i <= items.length + 10; i++) {
      newItems.add('Item $i');
    }

    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Pagination'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          // Show loading indicator at bottom
          if (index == items.length) {
            return Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          // Show regular item
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(items[index]),
              subtitle: Text('This is item number ${index + 1}'),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}