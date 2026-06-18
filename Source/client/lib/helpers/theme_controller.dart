import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF0F172A)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.light,
        ),
  checkboxTheme: CheckboxThemeData( // Customize the appearance of checkboxes
    fillColor: WidgetStateProperty.all(Colors.blue)  // Set the color of the checkbox when it is checked
        ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF0F172A)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
        ),
  checkboxTheme: CheckboxThemeData(
     // Customize the appearance of checkboxes
    fillColor: WidgetStateProperty.all(Colors.blue)// Set the color of the checkbox when it is checked
        ),
);

ValueNotifier<bool> isDarkMode = ValueNotifier(false);