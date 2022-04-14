import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:music_player_getx/core/theme/theme_app.dart';

class AppThemeLight extends IAppTheme {


  AppThemeLight._();
  static AppThemeLight instance = AppThemeLight._();


  @override
  ThemeData get theme => ThemeData(
    fontFamily: 'Heebo',
    colorScheme: _colorScheme(),

    brightness: Brightness.light,
    primaryColor: NeumorphicColors.background,
    primaryColorLight: Colors.pinkAccent,
    primaryColorDark: Colors.pinkAccent,
    canvasColor: Color(0xfffafafa),
    scaffoldBackgroundColor: NeumorphicColors.background,
    bottomAppBarColor: Color(0xffffffff),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      )
    ),
    cardColor: Color(0xffffffff),
    dividerColor: Color(0x1f000000),
    highlightColor: Color(0x66bcbcbc),
    splashColor: Color(0x66c8c8c8),
    selectedRowColor: Color(0xfff5f5f5),
    unselectedWidgetColor: Color(0x8a000000),
    disabledColor: Color(0x61000000),
    toggleableActiveColor: Color(0xffca6b02),
    secondaryHeaderColor: Color(0xfffff3e6),
    backgroundColor: Color(0xfffecf9a),
    dialogBackgroundColor: Color(0xffffffff),
    indicatorColor: Color(0xfffd8602),
    hintColor: Color(0x8a000000),
    errorColor: Color(0xffd32f2f),
  );

  _colorScheme() {
    return const ColorScheme(
      primary: NeumorphicColors.background,
      secondary: Colors.pinkAccent,
      surface: Color(0xffffffff),
      background: Color(0xfffecf9a),
      error: Color(0xffd32f2f),
      onPrimary: Color(0xff000000),
      onSecondary: Color(0xff000000),
      onSurface: Color(0xff000000),
      onBackground: Color(0xff000000),
      onError: Color(0xffffffff),
      brightness: Brightness.light,
    );
  }

  @override
  TextTheme get textTheme => ThemeData.light()
      .textTheme.copyWith(
    headline1: TextStyle(fontSize: 96,
        fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: TextStyle(fontSize: 60
        , fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
    ),
    headline4: TextStyle(fontSize: 34,
        fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),

  ).apply(
    bodyColor: Colors.red,
    displayColor: Colors.white,
  );
}