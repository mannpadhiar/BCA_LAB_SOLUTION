import 'dart:io';
import 'dart:math';

void main(){


  print("Enter number-");
  int number_1= int.parse(stdin.readLineSync()!);
  int sum_of_even_number = 0;
  int SUm_of_odd_number = 0;
  while(number_1!= 0){

    if(number_1 % 2 ==0 && number_1 > 0){
       sum_of_even_number += number_1;
    }

    else if ( number_1 % 2 != 0 && number_1 < 0){
      SUm_of_odd_number += number_1;
    }

    print("Enter number-");
    number_1= int.parse(stdin.readLineSync()!);
  }

  print("sum of even number is-${sum_of_even_number}");
  print("sum of odd number is-${SUm_of_odd_number}");
}