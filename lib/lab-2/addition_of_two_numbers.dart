import 'dart:io';

void main(){

  // take two input for addition

  int num1 = int.parse(stdin.readLineSync()!);
  int num2 = int.parse(stdin.readLineSync()!);

  //print their addition
  print(num1+num2);
}
