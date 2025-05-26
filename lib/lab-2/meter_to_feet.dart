import 'dart:io';

void main(){
  //take one input as a meter

  stdout.write('Enter your meter: ');
      int num = int.parse(stdin.readLineSync()!);

  //print it in a foot
  stdout.write(num*3.2804);
}
