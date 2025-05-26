import 'package:flutter/material.dart';

class DrawerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              title: Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page2()));
              },
            ),
            ListTile(
              title: Text('Page 3'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page3()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Text('Page 1 Here'),
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('Page 2 Here'),
      ),
    );
  }
}
class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body: Center(
        child: Text('Page 3 Here'),
      ),
    );
  }
}
