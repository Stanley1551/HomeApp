import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Constants/Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home app',
      theme: ThemeData(
        backgroundColor: AppColors.background,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },

    );
  }
}