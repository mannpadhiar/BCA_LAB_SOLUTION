import 'dart:math';

class Circle {
  double radius;

  Circle(this.radius);

  double area()=> pi * radius * radius;
  double perimeter() => 2 * pi * radius;
}

void main() {
  Circle c = Circle(5.0);
  print("----- Circle -----");
  print("Area: ${c.area()}");
  print("Perimeter: ${c.perimeter()}");
}
