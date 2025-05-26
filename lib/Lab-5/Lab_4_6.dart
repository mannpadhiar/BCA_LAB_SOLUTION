import 'dart:io';
import 'dart:math';
void main(){

  List<String> list1 = ['meet','mann','het'];
  List<int> list2  =[188,187,120];
}

void checkArr(List<int> list1,List<String> list2){

  Map<int,String> mp = {};

  for(int i = 0;i<list1.length;i++){
    mp[list1[i]] = list2[i];
  }
}

