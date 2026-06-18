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
  bottomAppBarTheme: BottomAppBarThemeData(
    color: const Color(0xFFE2E8F0),
  )
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF0F172A)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.dark,
        ),
  checkboxTheme: CheckboxThemeData(
     // Customize the appearance of checkboxes
    fillColor: WidgetStateProperty.all(Colors.blue)// Set the color of the checkbox when it is checked
        ),
  bottomAppBarTheme: BottomAppBarThemeData(
    color: const Color(0xFF1E293B),
  )
);

ValueNotifier<bool> isDarkMode = ValueNotifier(false);
// ValueNotifier<bool> es una variable especial que avisa a todos los que la escuchan cuando su valor cambia.
// por eso lo usamos aqui en este archivo, este archivo manda senales de que esta cambiando el tema de la aplicacion.

//¿Siempre así? Solo cuando necesitas que un valor sea global y que la UI reaccione al cambio sin usar setState.
// Para variables normales que no necesitan notificar nada, un bool simple está bien.

////color: Theme.of(context).cardColor,

// Theme.of(context) accede al tema activo de la app en ese momento, ya sea lightTheme o darkTheme.
// Y .cardColor es una propiedad del tema que devuelve el color asignado para tarjetas y contenedores.