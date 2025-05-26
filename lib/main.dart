import 'package:flutter/material.dart';
import 'package:flutterlabprograme/lab-10/temp.dart';
import 'package:flutterlabprograme/lab-10/temp2.dart';
import 'package:flutterlabprograme/lab-9/horizontal_part.dart';
import 'package:flutterlabprograme/lab-9/text_widget.dart';
import 'package:flutterlabprograme/lab-9/vertical_part.dart';
import 'package:flutterlabprograme/lab-10/stack_image.dart';

import 'Lab-13/registration_form.dart';
import 'lab-10/bottom_navigationbar_example.dart';
import 'lab-10/assets_image.dart';
import 'lab-10/birthday_card.dart';
import 'lab-10/cached_network_image_example.dart';
import 'lab-10/dynamic_birthday.dart';
import 'lab-10/named_navigation.dart';
import 'lab-10/navigation_example.dart';
import 'lab-11/log_in_screen.dart';
import 'lab-11/password_icon_textfield.dart';
import 'lab-11/validate_log_in_screen.dart';
import 'lab-12/home_screen.dart';
import 'lab-14/list_crud.dart';
import 'lab-22/lab_22_1.dart';
import 'lab-22/lab_22_2.dart';
import 'lab-22/lab_22_3.dart';
import 'lab-22/lab_22_4.dart';
import 'lab-22/lab_22_5.dart';
import 'lab-23/clint_request.dart';
import 'lab-23/pagination_example.dart';
import 'lab-25/tempp.dart';
import 'lab-9/TextField_to_text.dart';
import 'lab-9/nine_parts.dart';
import 'lab-9/textFieldExample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/temp' : (context) => Temp(),
        '/temp2' : (context) => Temp2(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ListCRUD(),
    );
  }
}
