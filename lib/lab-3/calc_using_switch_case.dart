import 'dart:io';

void main(){
  stdout.write('Enter your first number : ');
  int a = int.parse(stdin.readLineSync()!);
  stdout.write('Enter your second number : ');
  int b = int.parse(stdin.readLineSync()!);
  stdout.write('Enter your opration to perform number(+,-,x,/) : ');
  String op = stdin.readLineSync()!;
  //perform opration using switch case
  switch(op){
    case '+' : print(a+b);
    case '-' : print(a-b);
    case 'x' : print(a*b);
    case '/' : print(a/b);
  }
}

