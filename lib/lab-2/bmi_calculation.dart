import 'dart:io';
import 'dart:math';

void main(){

  //take height and weight as a input
  stdout.write('Enter your height');
  int height = int.parse(stdin.readLineSync()!);

  stdout.write('Enter your weight');
  int weight = int.parse(stdin.readLineSync()!);

  print(pow(height,2)/weight);
}

