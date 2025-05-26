import 'dart:io';

void main(){
  stdout.write('Enter your first number :');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter your second number :');
  int b = int.parse(stdin.readLineSync()!);

  stdout.write('Enter your third number :');
  int c = int.parse(stdin.readLineSync()!);

  //check for the largest number
  int res1 = (a>b)?a:b;
  int res2 = (b>c)?b:c;
  int res = (res1 > res2)?res1:res2;

  print('largest is ${res}');
}

