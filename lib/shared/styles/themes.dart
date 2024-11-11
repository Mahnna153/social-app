import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/constants.dart';

ThemeData lightMode = ThemeData(
  primarySwatch: defColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: defColor,
    //unselectedItemColor: Colors.grey,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlue,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    // subtitle1: TextStyle(
    //
    // ),
  ),
  fontFamily: "font_2",
);

ThemeData darkMode = ThemeData(
  primarySwatch: defColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 30.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlue,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: "font_2",
);
