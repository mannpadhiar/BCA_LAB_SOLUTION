import 'dart:io';

void main(){
  stdout.write('Enter your first number :');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Enter your second number :');
  int b = int.parse(stdin.readLineSync()!);

  stdout.write('Enter your third number :');
  int c = int.parse(stdin.readLineSync()!);

  //check for the largest number
  int res1;
  int res2;
  int res;

  if(a > b){
    res1 = a;
  }else{

    res1 = b;
  }

  if(b >c){

    res2 = b;
  }else{

    res2 = a;
  }

  if(res1 > res2){
    res = res1;
  }else{
    res = res2;
  }

  print('largest is ${res}');
}
