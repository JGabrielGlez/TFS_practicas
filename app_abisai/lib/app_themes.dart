import 'package:flutter/material.dart';

class AppThemes {
  // Configuración del Modo Claro
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Gris casi blanco
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(240, 22, 200, 44),    
      secondary: Color.fromARGB(255, 234, 123, 0),    
      tertiary: Color.fromARGB(200, 234, 22, 99),     
      surface: Color.fromARGB(190, 12, 120, 250),        // Fondo principal
      surfaceContainer: Color.fromARGB(230, 23, 87, 34),
    ),
  );

  // Configuración del Modo Oscuro
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF121212), // Negro mate
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(250, 230, 230, 90),     
      secondary: Color.fromARGB(200, 23, 57, 34),   
      tertiary: Color.fromARGB(230, 13, 62, 208),  
      surface: Color(0xFF121212),       // Fondo principal oscuro
      surfaceContainer: Color(0xFF231035), // Gris muy oscuro para estructura
    ),
  );
}