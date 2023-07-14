import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_controller/decoration/theme.dart';
import 'package:snipe_commander/utils/utils.dart';


AppTheme? _ThemeFromString(String name) {
  if (name == null) return null;
  return AppTheme.values.firstWhere(
          (element) => element.name.toLowerCase() == name.toLowerCase().trim());
}

/// provides the currently selected theme, saves changed theme preferences to disk
class AppThemeProvider extends ChangeNotifier {
  static const themePrefKey = 'theme';
  Color _mainColor = Colors.grey[800]!;
  Color _mainColorSecondary = ColorUtils.complement(Colors.grey[800]!);

  final SharedPreferences _prefs;
  late AppTheme _currentTheme;

  AppThemeProvider(this._prefs) {
    _currentTheme = _ThemeFromString(_prefs.getString(themePrefKey)) ?? AppTheme.Light;
  }

  Color getSecondaryFromColor(Color color) {
    Color res = ColorUtils.complement(color);

    if (this._currentTheme == AppTheme.Light)
      return res;
    else
      return ColorUtils.darken(res);
  }

  Color getSecondaryFromColorString(String colorString) {
    return ColorUtils.darken(getSecondaryFromColor(ColorUtils.fromHexString(colorString)));
  }

  Color getThemedColor(Color color) {
    if (this._currentTheme == AppTheme.Light)
      return color;
    else
      return ColorUtils.darken(color);
  }

  Color getThemedFromColorString(String colorString) {
    return getThemedColor(ColorUtils.fromHexString(colorString));
  }

  /// get the current theme
  AppTheme get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    // store updated theme on disk
    _prefs.setString(themePrefKey, theme.name);
    notifyListeners();
  }

  Color get mainColor{
    if (this._currentTheme == AppTheme.Light)
      return this._mainColor;
    else
      return ColorUtils.darken(this._mainColor);
  }

  Color get mainColorSecondary{
    if (this._currentTheme == AppTheme.Light)
      return this._mainColorSecondary;
    else
      return ColorUtils.darken(this._mainColorSecondary);
  }
}