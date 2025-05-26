import 'dart:io';

class BankAccount {
  String? accountNo;
  String? userName;
  String? email;
  String? accountType;
  double? balance;

  void getAccountDetails() {
    print('enter account number-');
    accountNo = stdin.readLineSync()!;
    print('enter userName-');
    userName = stdin.readLineSync()!;
    print('enter Email-');
    email = stdin.readLineSync()!;
    print('enter accountType-');
    accountType = stdin.readLineSync()!;
    print('enter balance-');
    balance = double.parse(stdin.readLineSync()!);
  }

  void displayAccountDetails() {
    print("----- Bank Account Details -----");
    print("Account No: $accountNo");
    print("Name: $userName");
    print("Email: $email");
    print("Account Type: $accountType");
    print("Balance: ₹$balance");
  }
}

void main() {
  BankAccount acc = BankAccount();
  acc.displayAccountDetails();
}
