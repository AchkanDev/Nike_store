import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/screen/home/home.dart';
import 'package:nike_store/widgets/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

ThemeMode themeMode = ThemeMode.light;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void loadTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString("theme") == "dark") {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nike Store',
      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme()
          : MyAppThemeConfig.light().getTheme(),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen(
            themeSwitchMode: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              setState(() {
                if (themeMode == ThemeMode.dark) {
                  sharedPreferences.setString("theme", "light");
                  themeMode = ThemeMode.light;
                } else {
                  sharedPreferences.setString("theme", "dark");
                  themeMode = ThemeMode.dark;
                }
              });
            },
          )),
    );
  }
}
