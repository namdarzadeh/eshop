import 'package:flutter/material.dart';

class CustomMaterialTheme {
  late final String fontFamily;

  CustomMaterialTheme({required final this.fontFamily});

  static const MaterialColor primaryColor = MaterialColor(0xff4a4e69, {
    50: Color(0xFFe9eaed),
    100: Color(0xFFc9cad2),
    200: Color(0xffa5a7b4),
    300: Color(0xff808396),
    400: Color(0xff656980),
    500: Color(0xff4a4e69),
    600: Color(0xff434761),
    700: Color(0xff3a3d56),
    800: Color(0xff32354c),
    900: Color(0xff22253b),
  });
  static const Color infoColor = Color(0xffB4C6D6);
  static const Color secondaryColor = Color(0xff9A8C98);
  static const Color backgroundColor = Color(0xffffffff);
  static const Color accentColor = Color(0xffF98A62);
  static const Color textColor = Color(0xFF22223B);
  static const Color liteTextColor = Color(0xFFF2E9E4);
  static const Color borderColor = Color(0xFF797d88);
  static const Color iconColor = Color(0xFFD1495B);
  static const Color successColor = Color(0xFF57B894);
  static const Color dangerColor = Color(0xFFD1495B);
  static const Color warningColor = Color(0xFFF98A62);
  static const Color disabledColor = Color(0xFFC6C2C2);

  ThemeData get themeData => ThemeData(
        fontFamily: fontFamily,
        /*primarySwatch: primaryColor,
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        primaryColorBrightness: Brightness.light,
        primaryColorLight: primaryColor[200],
        primaryColorDark: primaryColor[900],
        accentColor: accentColor,
        accentColorBrightness: Brightness.light,
        canvasColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        bottomAppBarColor: const Color(0xffffffff),
        cardColor: Colors.blue,
        dividerColor: const Color(0x1f000000),
        highlightColor: const Color(0x66bcbcbc),
        splashColor: const Color(0x66c8c8c8),
        selectedRowColor: const Color(0xfff5f5f5),
        unselectedWidgetColor: const Color(0x8a000000),
        disabledColor: disabledColor,
        buttonColor: const Color(0xffe0e0e0),
        toggleableActiveColor: const Color(0xff1e88e5),
        secondaryHeaderColor: const Color(0xffe3f2fd),
        backgroundColor: backgroundColor,
        dialogBackgroundColor: backgroundColor,
        indicatorColor: const Color(0xff2196f3),
        hintColor: const Color(0x8a000000),
        errorColor: dangerColor,*/
      );
}
