void main() {
  List<String> cities = ["Delhi", "Mumbai", "Bangalore", "Hyderabad", "Ahmedabad"];

  print("Original List: \n $cities");

  int index = cities.indexOf("Ahmedabad");

  cities[index] = "Surat";

  print("Updated List:");
  print(cities);
}
