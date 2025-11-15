import 'package:flutter/material.dart';


/// GetX Template Generator - fb.com/htngu.99
///

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData themeDataLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange[500],
    scaffoldBackgroundColor: Colors.grey[200],
    fontFamily: 'Inter');

final ThemeData themeDataDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange[700],
    scaffoldBackgroundColor: Colors.grey[850],
    fontFamily: 'Inter');

// void toggleDarkMode(isDarkMode) {
//   if (isDarkMode) {
//     Get.changeTheme(themeDataDark);
//   } else {
//     Get.changeTheme(themeDataLight);
//   }

