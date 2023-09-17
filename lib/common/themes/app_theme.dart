import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({this.isDarkMode = false});

  ThemeData theme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light);

  AppTheme copyWith({
    bool? isDarkMode,
  }) =>
      AppTheme(isDarkMode: isDarkMode ?? this.isDarkMode);
}
