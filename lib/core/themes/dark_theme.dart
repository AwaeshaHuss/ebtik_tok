import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Proxima Nova',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.grey.shade300,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey.shade300,
    ),
    bodySmall: TextStyle(
      color: Colors.grey.shade300,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white54,
  ),
);