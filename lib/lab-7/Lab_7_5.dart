class Member {
  String name;
  int age;
  String phone;
  String address;
  double salary;

  Member(this.name, this.age, this.phone, this.address, this.salary);

  void printSalary() {
    print("Salary: $salary");
  }
}

class Employee extends Member {
  String specialization;

  Employee(String name, int age, String phone, String address, double salary, this.specialization)
      : super(name, age, phone, address, salary);
}

class Manager extends Member {
  String department;

  Manager(String name, int age, String phone, String address, double salary, this.department)
      : super(name, age, phone, address, salary);
}

void main() {
  var emp = Employee("Amit", 25, "1234567890", "Ahmedabad", 40000, "Developer");
  var mgr = Manager("Sita", 35, "9876543210", "Rajkot", 60000, "IT");

  print("Employee: ${emp.name}, ${emp.age}, ${emp.phone}, ${emp.address}, ${emp.specialization}");
  emp.printSalary();

  print("Manager: ${mgr.name}, ${mgr.age}, ${mgr.phone}, ${mgr.address}, ${mgr.department}");
  mgr.printSalary();
}
