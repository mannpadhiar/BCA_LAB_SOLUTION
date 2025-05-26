class Shape{
  void colorShape(){
    print('coloring the shape');
  }
}

class Circle extends Shape{
  @override
  void colorShape(){
    print('circle has red color');
  }
}

void main(){
  Shape s = Shape();
  s.colorShape();

  Circle c = Circle();
  c.colorShape();
}