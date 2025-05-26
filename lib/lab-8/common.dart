import 'dart:io';

void main() {
  List<int> list1 = [];
  List<int> list2 = [];
  List<int> common = [];

  print("Enter 5 numbers for List 1:");
  for (int i = 0; i < 5; i++) {
    stdout.write("List 1 - Enter number ${i + 1}: ");
    list1.add(int.parse(stdin.readLineSync()!));
  }

  print("\nEnter 5 numbers for List 2:");
  for (int i = 0; i < 5; i++) {
    stdout.write("List 2 - Enter number ${i + 1}: ");
    list2.add(int.parse(stdin.readLineSync()!));
  }

  for (int num in list1) {
    if (list2.contains(num) && !common.contains(num)) {
      common.add(num);
    }
  }

  if (common.isEmpty) {
    print("No common elements found.");
  } else {
    print(common);
  }
}
