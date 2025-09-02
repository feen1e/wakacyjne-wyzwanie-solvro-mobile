import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

abstract interface class AppThemeData {
  ThemeData get light => ThemeData.light();

  ThemeData get dark => ThemeData.dark();
}

class AppTheme implements AppThemeData {
  @override
  ThemeData get light => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: ColorConsts.primary,
          surface: ColorConsts.surface,
        ),
        scaffoldBackgroundColor: ColorConsts.background,
        textTheme: GoogleFonts.latoTextTheme(_textTheme),
        appBarTheme: _appBarTheme,
        cardTheme: _cardTheme.data,
        useMaterial3: true,
      );

  @override
  ThemeData get dark => ThemeData(
        colorScheme: ColorScheme.dark(
          primary: ColorConsts.primary,
          surface: Colors.grey[850]!,
          onPrimary: ColorConsts.onPrimary,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: GoogleFonts.latoTextTheme(_textTheme.apply(bodyColor: Colors.white)),
        appBarTheme: _appBarTheme.copyWith(
          backgroundColor: Colors.grey[850],
        ),
        cardTheme: _cardTheme
            .copyWith(
              color: Colors.grey[800],
            )
            .data,
        useMaterial3: true,
      );
}

const TextTheme _textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16),
  bodyMedium: TextStyle(fontSize: 14),
  titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
);

final AppBarTheme _appBarTheme = AppBarTheme(
  backgroundColor: ColorConsts.primary,
  foregroundColor: ColorConsts.onPrimary,
  elevation: 2,
  centerTitle: true,
  titleTextStyle: _textTheme.headlineSmall?.copyWith(color: ColorConsts.onPrimary),
);

final CardTheme _cardTheme = CardTheme(
  color: ColorConsts.surface,
  elevation: 2,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  margin: const EdgeInsets.all(8),
);

extension AppThemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

class ColorConsts {
  static const Color primary = Color.fromARGB(255, 60, 117, 170);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color background = Color(0xFFFFFFFF);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
}
