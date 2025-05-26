import 'dart:io';
import 'dart:math';

void main(){
  print("Enter number-");
  int number= int.parse(stdin.readLineSync()!);

  int count = 0;
  //we can also use number/2 instant of sqrt(number)
  for(int i = 2;i<=sqrt(number);i++){
    if(number % i == 0){
      count++;
    }
  }
  if(count == 0) {
    print("Given number is not a Prime number.");
  }
  else{
    print("Given number is a Prime");
  }
}