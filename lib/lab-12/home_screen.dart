// Import necessary packages
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView(
        children: [
          ListTile(
            title: Text("Navigate to Login"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
          ),
          ListTile(
            title: Text("Navigate to Profile"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen())),
          ),
          ListTile(
            title: Text("Navigate to Todo List"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TodoScreen())),
          ),
          ListTile(
            title: Text("Navigate to Music Player"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MusicPlayerScreen())),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Login')),
            TextButton(onPressed: () {}, child: Text('Don\'t have an account? Sign Up')),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/avatar.png')),
            SizedBox(height: 10),
            Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('johndoe@example.com'),
            SizedBox(height: 10),
            Text('Flutter Developer, Tech Enthusiast'),
            Spacer(),
            ElevatedButton(onPressed: () {}, child: Text('Edit Profile')),
          ],
        ),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> todos = ['Buy groceries', 'Walk the dog', 'Read a book'];
  List<bool> completed = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => CheckboxListTile(
          title: Text(todos[index]),
          value: completed[index],
          onChanged: (val) {
            setState(() {
              completed[index] = val!;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class MusicPlayerScreen extends StatelessWidget {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.music_note_outlined, size: 120, color: Colors.blue),
            SizedBox(height: 10),
            Text('Song Title', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Artist Name'),
            Spacer(),
            Slider(
              value: _sliderValue,
              activeColor: Colors.blue,
              onChanged: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow, size: 40)),
                IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}