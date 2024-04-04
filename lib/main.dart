import 'package:flutter/material.dart';
import 'package:fourth_app/widgets/expenses.dart';
import 'package:flutter/services.dart';
var kcolorscheme =  ColorScheme.fromSeed(seedColor: const Color.fromARGB(255,96,59,181));
var kdarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 9, 55, 125),
  );
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(
  MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kdarkColorScheme,
      cardTheme: const CardTheme().copyWith(
          color: kdarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdarkColorScheme.primaryContainer,
            foregroundColor: kdarkColorScheme.onPrimaryContainer,
          ),
        ),
    ),
      theme: ThemeData().copyWith(
        colorScheme: kcolorscheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorscheme.onPrimaryContainer,
          foregroundColor: kcolorscheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kcolorscheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorscheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
          fontWeight: FontWeight.bold, 
          color: kcolorscheme.onSecondaryContainer, 
          fontSize: 17),
        ),
        ),
        themeMode: ThemeMode.system,
      home:const Expenses(),
    ),
  );
//});
}
  