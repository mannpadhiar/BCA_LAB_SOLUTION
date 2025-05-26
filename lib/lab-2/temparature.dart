import 'dart:io';

void main(){
//take one input of temperature
int temp = int.parse(stdin.readLineSync()!);

stdout.write(((temp-32)*5)/9);
}
