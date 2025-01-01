import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _selectedColor = Colors.green;
  bool _isDarkMode = false;
  String _fontStyle = "Normal";

  Color get selectedColor => _selectedColor;
  bool get isDarkMode => _isDarkMode;
  String get fontStyle => _fontStyle;

  void changeColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  void toggleDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

  void changeFontStyle(String style) {
    _fontStyle = style;
    notifyListeners();
  }

  TextStyle getTextStyle() {
    switch (_fontStyle) {
      case "Gras":
        return TextStyle(fontWeight: FontWeight.bold);
      case "Italique":
        return TextStyle(fontStyle: FontStyle.italic);
      case "Normal":
      default:
        return TextStyle(fontWeight: FontWeight.normal);
    }
  }
}