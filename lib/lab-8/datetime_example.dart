import 'package:intl/intl.dart';

void main(){
  DateTime now = DateTime.now();

  print(DateFormat('dd/MM/yyyy').format(now));
  print(DateFormat('dd-MM-yyyy').format(now));
  print(DateFormat('dd-MMM-yyyy').format(now));
  print(DateFormat('dd-MM-yy').format(now));
  print(DateFormat('dd MMM, yyyy').format(now));
}