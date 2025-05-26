import 'dart:io';

void main() {

  //take the length of your array
  stdout.write('Enter length of your array: ');
  int length = int.parse(stdin.readLineSync()!);

  //initialize a arry and a totol sum
  List<double> ansList = [];
  double sum = 0.0;

  //form a loop to the length that take a input which add in list and sum
  for (int i = 0; i < length; i++) {
    stdout.write('Enter your $i-th element: ');
    double temp = double.parse(stdin.readLineSync()!);
    ansList.add(temp);
    sum += temp;
  }

  //print it
  print('Your list is: $ansList');
  print('Your sum is: ${sum.toStringAsFixed(2)}');
}

