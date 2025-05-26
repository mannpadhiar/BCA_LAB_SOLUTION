import 'dart:io';

class Candidate {
  int? id;
  String? name;
  int? age;
  double? weight;
  double? height;



  void getCandidateDetails() {
    print('enter id-');
    id = int.parse(stdin.readLineSync()!);
    print('enter name-');
    name = stdin.readLineSync()!;
    print('enter age-');
    age = int.parse(stdin.readLineSync()!);
    print('enter weight-');
    weight = double.parse(stdin.readLineSync()!);
    print('enter height-');
    height = double.parse(stdin.readLineSync()!);
  }

  void displayCandidateDetails() {
    print("----- Candidate Details -----");
    print("ID: $id");
    print("Name: $name");
    print("Age: $age");
    print("Weight: $weight kg");
    print("Height: $height cm");
  }
}

void main() {
  Candidate c = Candidate();
  c.getCandidateDetails();
  c.displayCandidateDetails();
}
