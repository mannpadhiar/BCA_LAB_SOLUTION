import 'dart:io';
import 'dart:math';

void main(){
  print("Enter a String-");
  String a = (stdin.readLineSync()!);
  String reverse_String = "";

  for(int i=a.length-1;i>=0;i--){

    reverse_String += a[i];

  }
  print(reverse_String);

}