import 'package:flutter/material.dart';

class MyTheme{
  static const Color lightPrimaryColor = Color(0XFF5D9CEC);

  // static const Color lightScaffoldBackgroundColor=Color(0XFFDFECDB);
  static const Color grayColor = Color(0XFFC8C9CB);
  static const Color greenColor = Color(0XFF61E757);

  static final ThemeData lightTheme = ThemeData(
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: TextTheme(
        headline4: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
        headline6: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        size: 36,color: lightPrimaryColor
      ),
      unselectedIconTheme: IconThemeData(
        size: 30,color: grayColor
      ),
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,width: 4
        )
      )
    )
,appBarTheme: AppBarTheme(
      elevation: 0,
    backgroundColor: Colors.transparent,
  ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
        )
      )
    )

  );
}