import 'dart:io';
class Friend{
  String name;
  String number;

  Friend(this.name,this.number);

  void displayDetails(){
    print(this.name);
    print(this.number);
  }
}

void main(){

  Map<String,Friend> friendsInfo = {
    'John': Friend('John', '123-456-7890'),
    'Alice': Friend('Alice', '987-654-3210'),
    'Bob': Friend('Bob', '555-123-4567'),
    'Eve': Friend('Eve', '555-765-4321'),
  };

  print('search your name :');
  String name = stdin.readLineSync()!;

  if(friendsInfo.containsKey(name)){
    print('name : ${friendsInfo[name]!.name}, number: ${friendsInfo[name]!.number}');
  }
}