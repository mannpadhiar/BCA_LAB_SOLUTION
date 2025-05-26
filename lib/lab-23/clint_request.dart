import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ClintRequest extends StatefulWidget {
  const ClintRequest({super.key});

  @override
  State<ClintRequest> createState() => _ClintRequestState();
}

class _ClintRequestState extends State<ClintRequest> {

  List<Map<String,dynamic>> users = [];

  Future<List<Map<String,dynamic>>> fetchData() async{

    //HttpClint is inbuilt flutter component to make http requests rather then adding third party package like 'http'
    var clint = HttpClient();

    //this is not making any request in your uri this just make an instance of request
    final request  = await clint.getUrl(Uri.parse('https://67c5368cc4649b9551b5aa00.mockapi.io/mmony/data'));

    //close() use to make an http request from intense
    final response = await request.close();

    if(response.statusCode == HttpStatus.ok){
      //response is in ByteStream so we have to make it in String
      final responseBody = await response.transform(utf8.decoder).join();
      final List<Map<String,dynamic>> data = List<Map<String, dynamic>>.from(jsonDecode(responseBody));
      print(data);
      return data;
    }
    else{
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }else{
                  users = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(users[index]['name']),
                          subtitle: Text(users[index]['number']),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
