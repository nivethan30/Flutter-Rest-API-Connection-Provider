import 'package:flutter/material.dart';
import '../utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData = AppTheme.light();

  ThemeData get themeData => _themeData;

  void toggleTheme() async {
    _themeData =
        (_themeData == AppTheme.light()) ? AppTheme.dark() : AppTheme.light();
    await saveTheme();
    notifyListeners();
  }

  Future<void> saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? theme = (_themeData == AppTheme.light()) ? 0 : 1;
    prefs.setInt('theme', theme);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? theme = prefs.getInt('theme');
    if (theme == null) {
      _themeData = AppTheme.light();
    } else {
      _themeData = (theme == 0) ? AppTheme.light() : AppTheme.dark();
    }
    notifyListeners();
  }
}
