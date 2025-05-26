import 'package:flutter/material.dart';

class ListCRUD extends StatefulWidget {
  ListCRUD({super.key});

  @override
  State<ListCRUD> createState() => _ListCRUDState();
}

class _ListCRUDState extends State<ListCRUD> {
  List<String> Users = [];
  List<String> SearchUserList = [];
  TextEditingController Name = TextEditingController();
  TextEditingController SearchVal = TextEditingController();
  bool isEditButton = false;
  bool isSearchOptionActive = false;
  int? editIndex;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple CRUD"),
        backgroundColor: Colors.blue,
        actions : [
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: IconButton(onPressed: (){
              setState(() {
                isSearchOptionActive = !isSearchOptionActive;
              });
            }, icon: Icon(Icons.search)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isSearchOptionActive?
        Column(
          children: [
            TextFormField(
              controller: SearchVal,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged:(value){

                SearchUserList.clear();

                for(int i=0;i<Users.length;i++){
                  if(Users[i].toLowerCase().toString().contains(value)){
                    setState(() {
                      SearchUserList.add(Users[i]);
                    });
                    if(SearchVal.text.toString().isEmpty){
                      SearchUserList.clear();
                    }
                  }
                }
              },
            ),
            Expanded(
              child: ListView.builder(itemCount :SearchUserList.length,itemBuilder: (context,index){
                return Container(
                  child:  Text(SearchUserList[index]),
                );
              }),)
          ],
        )
            :Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: Name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                isEditButton ?  FilledButton(
                  onPressed: () {
                    setState(() {
                      if (Name.text.isNotEmpty) {
                        Users[editIndex!] = Name.text;
                        Name.clear();
                      }
                      isEditButton = !isEditButton;
                    });
                  },
                  child: Text('Edit'),style: FilledButton.styleFrom(backgroundColor: Colors.blue))
                  : FilledButton(
                  onPressed: () {
                    setState(() {
                      if (Name.text.isNotEmpty) {
                        Users.add(Name.text);
                        Name.clear();
                      }
                    });
                  },
                  child: Text('Add User'),style: FilledButton.styleFrom(backgroundColor: Colors.blue)
              ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Users.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No users',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: Users.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(Users[index]),
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            setState(() {
                              Name.text = Users[index];
                              editIndex = index;
                              isEditButton = !isEditButton;
                            });
                          }, icon: Icon(Icons.edit)),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Users.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      )
                    ],
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
