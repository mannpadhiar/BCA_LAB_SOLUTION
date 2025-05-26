import 'dart:io';

void main(){

//take five input numbers
stdout.write('Enter your 1 number : ');
int sub1 = int.parse(stdin.readLineSync()!);
stdout.write('Enter your 2 number : ');
int sub2 = int.parse(stdin.readLineSync()!);
stdout.write('Enter your 3 number : ');
int sub3 = int.parse(stdin.readLineSync()!);
stdout.write('Enter your 4 number : ');
int sub4 = int.parse(stdin.readLineSync()!);
stdout.write('Enter your 5 number : ');
int sub5 = int.parse(stdin.readLineSync()!);

//print their percentage
stdout.write((sub1 + sub2 + sub3 + sub4 + sub5)/5);
}
