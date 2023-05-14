import 'package:flutter/material.dart';

class MyAppThemeConfig {
  final primaryColor;
  final primaryVariant;
  final backgroundColor;
  final surfaceColor;
  final errorColor;
  final onError;
  final secondaryColor;
  // static const primaryTextColor = Color(0xff262A35);
  final secondaryTextColor;
  final onPrimary;
  final onSecondary;
  final onSurface;
  final onBackground;
  final brightness;

  MyAppThemeConfig.light()
      : primaryColor = Color(0xff6200EE),
        primaryVariant = Color(0xff3700B3),
        backgroundColor = Color(0xffffffff),
        surfaceColor = Color(0xffffffff),
        errorColor = Color(0xffB00020),
        onError = Colors.white,
        secondaryColor = Color(0xff03DAC6),
        secondaryTextColor = Color(0xffB3B6BE),
        onPrimary = Colors.white,
        onSecondary = Colors.black,
        onBackground = Colors.black,
        onSurface = Colors.black,
        brightness = Brightness.light;

  MyAppThemeConfig.dark()
      : primaryColor = Color(0xffBB86FC),
        primaryVariant = Color(0xff3700B3),
        backgroundColor = Color(0xff121212),
        surfaceColor = Color(0xff121212),
        errorColor = Color(0xffCF6679),
        onError = Colors.black,
        secondaryColor = Color(0xff03DAC5),
        secondaryTextColor = Color(0xffB3B6BE),
        onPrimary = Colors.black,
        onSecondary = Colors.black,
        onBackground = Colors.white,
        onSurface = Colors.white,
        brightness = Brightness.dark;

  ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme(
          brightness: brightness,
          primary: primaryColor,
          onPrimary: onPrimary,
          secondary: secondaryColor,
          onSecondary: onSecondary,
          error: errorColor,
          onError: onError,
          background: backgroundColor,
          onBackground: onBackground,
          surface: surfaceColor,
          onSurface: onSurface),
      fontFamily: "iranYekan",
      backgroundColor: backgroundColor,
      brightness: brightness,
      primaryColor: primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          )),
      dividerColor: surfaceColor,
      scaffoldBackgroundColor: backgroundColor,
      // textTheme: languageCode == "en" ? enPrimaryTextTheme : faPrimaryTextTheme,
      // dividerColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimary,
      ),
    );
  }
}


// class DarkTheme {
//   static const primaryColor = Color(0xffBB86FC);
//   static const primaryVariant = Color(0xff3700B3);
//   static const backgroundColor = Color(0xff121212);
//   static const surfaceColor = Color(0xff121212);
//   static const errorColor = Color(0xffCF6679);
//   static const onError = Colors.black;
//   static const secondaryColor = Color(0xff03DAC5);
//   // static const primaryTextColor = Color(0xff262A35);
//   static const secondaryTextColor = Color(0xffB3B6BE);
//   static const onPrimary = Colors.black;
//   static const onSecondary = Colors.black;
//   static const onBackground = Colors.white;
//   static const onSurface = Colors.white;
// }

// class LightTheme {
//   static const primaryColor = Color(0xff6200EE);
//   static const primaryVariant = Color(0xff3700B3);
//   static const backgroundColor = Color(0xffffffff);
//   static const surfaceColor = Color(0xffffffff);
//   static const errorColor = Color(0xffB00020);
//   static const onError = Colors.white;
//   static const secondaryColor = Color(0xff03DAC6);
//   // static const primaryTextColor = Color(0xff262A35);
//   static const secondaryTextColor = Color(0xffB3B6BE);
//   static const onPrimary = Colors.white;
//   static const onSecondary = Colors.black;
//   static const onBackground = Colors.black;
//   static const onSurface = Colors.black;
// }

