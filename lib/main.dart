import 'package:flutter/material.dart';
import 'autocomplete.dart';
import 'form.dart';
import 'keyboard.dart';
import 'formfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(primarySwatch: Colors.blue),

      // home: AutoComplete(), // Change this to AutoComplete() to use the autocomplete page
      // home: const FormPage(), // Change this to FormPage() to use the form page
      // home:
      //     const FormScreen(), // Change this to FormScreen() to use the form screen
      home:
          const KeyboardExample(), // Change this to KeyboardExample() to use the keyboard
    );
  }
}
