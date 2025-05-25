import 'package:flutter/material.dart';

class AppColor {
  // static const primary = Color(0xFF8852A8);
  static const primary = Color.fromRGBO(136, 82, 168, 0.8);
  static const primary2 = Color(0xFFEEDBED);
  static const hintTextFieldColor = Color.fromRGBO(136, 82, 168, 0.2);
  // static const primary = Color.fromARGB(255, 15, 167, 190);
  static const secondary = Color.fromARGB(255, 31, 198, 228);
  static const colorTelu = Color.fromARGB(255, 237, 237, 237);
  static const mainColor = Color(0xFF000000);
  static const darkmode = Color(0xFF1C1B1F);
  static const cardColor = Colors.white;
  static const appBgColor = Color(0xFFF7F7F7);

  static const btnColor = Color.fromARGB(255, 160, 22, 153);
  static const inActiveColor = Colors.grey;
  static const shadowColor = Colors.black87;
  static const textBoxColor = Colors.white;

  static final ThemeData customLightTheme = ThemeData(
    // scaffoldBackgroundColor: AppColor.appBgColor,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColor.primary,
    cardColor: AppColor.cardColor,
    hintColor: AppColor.hintTextFieldColor,
    shadowColor: AppColor.shadowColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.colorTelu,
      foregroundColor: AppColor.mainColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 252, 248, 252),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(
        color: hintTextFieldColor,
        fontSize: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColor.primary,
          width: 2,
        ),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: primary,
      unselectedLabelColor: Colors.grey,
      indicatorColor: primary,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.mainColor),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: AppColor.textBoxColor,
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.primary),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: AppColor.primary, width: 2),
    //   ),
    // ),
    useMaterial3: true,
  );

  static final ThemeData customDarkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 40, 39, 43),
    primaryColor: AppColor.appBgColor,
    cardColor: Colors.grey[900],
    hintColor: AppColor.hintTextFieldColor,
    shadowColor: Colors.black54,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.darkmode,
      foregroundColor: AppColor.hintTextFieldColor,
      elevation: 0,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primary2,
      foregroundColor: primary,
    ),
    cardTheme: CardTheme(
      color: Colors.grey[700],
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColor.primary.withOpacity(0.3),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // hintStyle: ,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.grey[800],
      // fillColor: AppColor.primary2,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primary, width: 2),
      ),
    ),
    useMaterial3: true,
  );
}
