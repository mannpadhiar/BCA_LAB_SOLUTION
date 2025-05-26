import 'dart:io';

void main(){
  print('enter 1st sub marks :');
  int a = int.parse(stdin.readLineSync()!);

  print('enter 2nd sub marks :');
  int b = int.parse(stdin.readLineSync()!);

  print('enter 3rd sub marks :');
  int c = int.parse(stdin.readLineSync()!);

  print('enter 4th sub marks :');
  int d = int.parse(stdin.readLineSync()!);

  print('enter 5th sub marks :');
  int e = int.parse(stdin.readLineSync()!);

  double res = (a+b+c+d+e)/5;

  if(res < 35){
    print('fail!!');
  }
  else if(res>=35 && res<45){
    print('pass');
  }
  else if(res>=45 && res<60){
    print('second');
  }
  else if(res>=60 && res<70){
    print('pass');
  }
  else{
    print('Distinction');
  }
}
