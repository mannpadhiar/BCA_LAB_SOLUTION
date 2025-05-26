import 'dart:io';

void main(){

  print("Enter first number-");

  //readLineSync() reads a line of text as a String? (nullable string) from the input.
  int number_1 = int.parse(stdin.readLineSync()!);

  int factorial = 1;
  for(int i = 1;i<=number_1;i++){
    factorial = factorial * i;
  }
  print(factorial);
}