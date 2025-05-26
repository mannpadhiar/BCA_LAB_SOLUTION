class MyClass{
  void sayHello(){
    print('hello');
  }
}

class MethodCaller{
  void callMethod(Function method){
    method();
  }
}

void main(){
  MyClass obj = MyClass();
  MethodCaller m = MethodCaller();
  m.callMethod(obj.sayHello);
}