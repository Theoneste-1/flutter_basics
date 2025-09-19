// ignore_for_file: library_private_types_in_public_api

import 'package:counter_theming_app/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  // them mode state (0 = light, 1 = dark, 2 = system)

  int _themeMode = 0;

  //load theme preference when app starts

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  _loadThemePreference() async  {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _themeMode = prefs.getInt('themeMode') ?? 0;;
    });
  }

 _saveThemePreference(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', value);
  }


void _changeTheme(int newThemeMode) {
    setState(() {
      _themeMode = newThemeMode;
      _saveThemePreference(newThemeMode);
    });
  }

  ThemeData _getCurrentTheme() {
    switch (_themeMode) {
      case 0:
        return ThemeData.light();
      case 1:
        return ThemeData.dark();
      case 2:
        return ThemeData.light(); // For simplicity, using light as system
      default:
        return ThemeData.light();
    }
  }

    String _getThemeModeName() {
    switch (_themeMode) {
      case 0:
        return 'Light Theme';
      case 1:
        return 'Dark Theme';
      case 2:
        return 'System Theme';
      default:
        return 'Light Theme';
    }
  }

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: _getCurrentTheme(),
      home: CounterScreen(
        themeMode: _themeMode,
        changeTheme: _changeTheme,
        themeModeName: _getThemeModeName(),
      ),
    );
  }
}
