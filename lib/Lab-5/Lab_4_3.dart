import 'dart:io';
void main(){
  print("Enter number one - ");
  int n1 = int.parse(stdin.readLineSync()!);

  fibonacci(n1);
}

void fibonacci(int n){
  int a = 0;
  int b = 1;
  int c = 0;
  print(a);
  print(b);

    for(int i=0;i<=n;i++){
    c = a;
    a = b;
    b = c + a;
    print(b);
    }
}

