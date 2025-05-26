import 'package:flutter/material.dart';

class TabbarViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabView Example'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
              Tab(text: 'Tab 3'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Page 1')),
            Center(child: Text('Page 2')),
            Center(child: Text('Page 3')),
          ],
        ),
      ),
    );
  }
}
