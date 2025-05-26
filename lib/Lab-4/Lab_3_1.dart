import 'dart:io';

void main(){
  print("Enter range-");
  print("Enter first number-");
  int number_1 = int.parse(stdin.readLineSync()!);

  print("Enter second number-");
  int number_2 = int.parse(stdin.readLineSync()!);

  for(int i = number_1;i<=number_2;i++){
    if(number_1 % 2 == 0 && number_1 % 3 != 0){
      print(i);
    }
  }
}