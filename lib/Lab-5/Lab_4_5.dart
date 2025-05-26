import 'dart:io';
import 'dart:math';
void main(){

  var list = [1,2,3,4,5,6,7,8,9,10,13,12,15];

  checkArr(list);

}

void checkArr(var n){
  int evenCount = 0;
  int oddCount = 0;
  for(int i=0;i<n.length;i++){
    if(n[i] % 2 == 0){
      evenCount++;
    }
    else{
      oddCount++;
    }
  }
  print("Odd numbers are - $oddCount");
  print("Even numbers are - $evenCount");
}

