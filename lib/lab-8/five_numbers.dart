import 'dart:io';
void main(){
  List<int> numbers = [];

  for(int i=0;i<5;i++){
    print('Enter your ${i+1}th number : ');
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  numbers.sort();

  print(numbers);
}