import 'package:flutter/material.dart';
import 'package:gadget_store/config/themes/app_color.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColorConstant.primaryColor,
        ),
        fontFamily: 'Montserrat',
        useMaterial3: true,

        // Change app bar color
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColorConstant.appBarColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ));
  }
}
