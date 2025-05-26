import 'dart:io';

void main(){

  stdout.write('Enter length of your array : ');
  int length  = int.parse(stdin.readLineSync()!);

  List<int> ansList = [];
  int sum = 0;

  for(int i=0;i<length;i++){
    stdout.write('Enter your $i th element : ');
    int temp  = int.parse(stdin.readLineSync()!);

    ansList.add(temp);
    sum += temp;
  }

  print('your list is : $ansList');
  print('your sum is $sum');
}

