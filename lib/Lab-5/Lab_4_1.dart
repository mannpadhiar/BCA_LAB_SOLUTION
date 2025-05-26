import 'dart:io';
void main(){
print("Enter principal");
int p = int.parse(stdin.readLineSync()!);

print("Enter rate of interest");
int r = int.parse(stdin.readLineSync()!);

print("Enter time");
int t = int.parse(stdin.readLineSync()!);

simpInterest(p,r,t);
}
void simpInterest(int p,int r,int t){
  print((p*r*t)/100);
}
