import 'dart:io';
import 'dart:math';
void main(){
  print("Enter a number - ");
  int n1 = int.parse(stdin.readLineSync()!);

  if(check(n1) == 1){
    print("Prime");
  }
  else{
    print("Not a prime");
  }
}

int check(int n){
  int count  = 0;
    for(int i = 2;i < sqrt(n);i++){
      if(n % i == 0){
        count++;
      }
  }
    if(count == 0){
      return(1);
    }
    else{
      return(0);
    }
}

