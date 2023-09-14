import 'package:flutter/material.dart';
import 'package:shopping_app99/config/custom_config.dart';

final lightTheme = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Color(0xFF82E0AA),
    backgroundColor: Color(0xFFF2F4F4),
    dividerColor: Color(0xffD5D8DC),
    hoverColor: Color(0xffd6f5e3),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline2: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline3: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline4: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline5: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline6: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      subtitle1: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Color(0xFF3C3F41),
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.normal,
      ),
    ));

final darkTheme = ThemeData(
    primarySwatch: Colors.purple,
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    dividerColor: Color(0xffD5D8DC),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
      ),
      subtitle1: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontFamily: CustomConfig.defaultFontFamily,
        fontWeight: FontWeight.normal,
      ),
    ));

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  ThemeNotifier(this._themeData);
  getTheme() => _themeData;

  // for set theme mode
  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
