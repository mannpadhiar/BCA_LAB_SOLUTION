import 'dart:io';
void main(){
  print("Enter number one - ");
  int n1 = int.parse(stdin.readLineSync()!);

  print("Enter rate of number two - ");
  int n2 = int.parse(stdin.readLineSync()!);

  maxOfTwo(n1,n2);
}


void maxOfTwo(int p,int r){
  if(p > r){
    print("$p is largest");
  }
  else{
    print("$r is largest");
  }
}
