import 'package:expense_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 237, 141, 15));

var kDarkColorTheme = ColorScheme.fromSeed(brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 91, 125),
    );
void main() {
  // WidgetsFlutterBinding.ensureInitialized(); // Enable it if require fixed orientation
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn){
  runApp(
    MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: kDarkColorTheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kDarkColorTheme.secondaryContainer,
                foregroundColor: kDarkColorTheme.primaryContainer),
            cardTheme: const CardTheme().copyWith(
                color: kDarkColorTheme.primaryContainer,
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kDarkColorTheme.primaryContainer,
                    foregroundColor: kDarkColorTheme.onPrimaryContainer)),
            ),
                    
        theme: ThemeData().copyWith(
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
                backgroundColor: kColorScheme.onPrimaryContainer,
                foregroundColor: kColorScheme.primaryContainer),
            cardTheme: const CardTheme().copyWith(
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorScheme.onPrimaryContainer,
                    foregroundColor: kColorScheme.primaryContainer)),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kColorScheme.onSecondaryContainer))),
        home: const Expenses()),
  );
  // });
}
