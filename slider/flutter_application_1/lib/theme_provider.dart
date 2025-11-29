import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color _primaryColor = Colors.blue;
  String _colorName = 'أزرق';

  Color get primaryColor => _primaryColor;
  String get colorName => _colorName;

  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'أحمر', 'color': Colors.red},
    {'name': 'أخضر', 'color': Colors.green},
    {'name': 'أزرق', 'color': Colors.blue},
    {'name': 'أصفر', 'color': Colors.yellow},
  ];

  void updateColor(Color color, String name) {
    _primaryColor = color;
    _colorName = name;
    notifyListeners();
  }

  LinearGradient get gradientBackground => LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          _primaryColor.withOpacity(0.8),
          _primaryColor,
          _primaryColor.withOpacity(0.6),
        ],
      );
}
