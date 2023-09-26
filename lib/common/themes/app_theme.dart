import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

final colors = <Color>[
  HexColor("#aac6f9"),
  HexColor("#fed8c3"),
  HexColor("#88ba5d"),
  HexColor("#ffe9b0")
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false})
      : assert(selectedColor >= 0, 'Selected colour must be greater then 0'),
        assert(selectedColor < colors.length,
            'Selected colour must less or equal than ${colors.length - 1}');

  ThemeData theme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colors[selectedColor]);

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
          selectedColor: selectedColor ?? this.selectedColor,
          isDarkMode: isDarkMode ?? this.isDarkMode);
}
