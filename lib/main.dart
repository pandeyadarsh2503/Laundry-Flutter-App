import 'package:flutter/material.dart';
import 'package:laundry/home_page.dart';
import 'package:laundry/login.dart';
import 'package:laundry/main_shell.dart';
import 'package:laundry/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'signup': (context) => Signup(),
      'main_page': (context) => MainShell(),}
  ));
}

