import 'dart:io';
import 'dart:math';

void main(){
  print("Enter number-");
  double number = double.parse(stdin.readLineSync()!);

  double count = 0;
  double reverse_number = 0;

  while(number > 0){
    count = number % 10;
    reverse_number = (reverse_number * 10) + count;
    number = number / 10;
  }
  print(reverse_number);
}