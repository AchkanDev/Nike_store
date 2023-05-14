import 'package:flutter/material.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/widgets/theme.dart';

Brightness brightness = Brightness.dark;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final defualtStyleText = const TextStyle(fontFamily: "iranYekan");
  ThemeMode themeMode = ThemeMode.light;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike Store',
      // theme: MyAppThemeConfig.light().getTheme(),
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme()
          : MyAppThemeConfig.light().getTheme(),
      // theme: ThemeData(
      //   textTheme: TextTheme(
      //     bodyMedium: defualtStyleText,
      //     bodySmall:
      //         defualtStyleText.apply(color: LightTheme.secondaryTextColor),
      //     titleLarge: defualtStyleText.copyWith(fontWeight: FontWeight.bold),
      // ),

      // colorScheme: const ColorScheme.light(
      //   primary: LightTheme.primaryColor,
      //   secondary: LightTheme.secondaryColor,
      //   background: LightTheme.backgroundColor,
      //   primaryVariant: LightTheme.primaryVariant,
      //   surface: LightTheme.surfaceColor,
      //   error: LightTheme.errorColor,
      //   onError: LightTheme.onError,
      //   onPrimary: LightTheme.onPrimary,
      //   onSecondary: LightTheme.onPrimary,
      //   onBackground: LightTheme.onBackground,
      //   onSurface: LightTheme.onSurface,
      // ),
      // colorScheme: const ColorScheme.dark(
      //   secondary: DarkTheme.secondaryColor,
      //   primary: DarkTheme.primaryColor,
      //   background: DarkTheme.backgroundColor,
      //   primaryVariant: DarkTheme.primaryVariant,
      //   surface: DarkTheme.surfaceColor,
      //   error: DarkTheme.errorColor,
      //   onError: DarkTheme.onError,
      //   onPrimary: DarkTheme.onPrimary,
      //   onSecondary: DarkTheme.onPrimary,
      //   onBackground: DarkTheme.onBackground,
      //   onSurface: DarkTheme.onSurface,
      // ),
      // ),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen(
            themeSwitchToModeDark: () {
              setState(() {
                themeMode = ThemeMode.light;
                brightness = Brightness.light;
              });
            },
            themeSwitchToModeLight: () {
              setState(() {
                themeMode = ThemeMode.dark;
                brightness = Brightness.dark;
              });
            },
          )),
    );
  }
}
