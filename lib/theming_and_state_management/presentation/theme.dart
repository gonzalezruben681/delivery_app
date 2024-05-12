import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BorderRadius,
        BorderSide,
        BottomAppBarTheme,
        Color,
        ColorScheme,
        Colors,
        InputDecorationTheme,
        OutlineInputBorder,
        // TextTheme,
        ThemeData;
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  static const purple = Color(0xFF5117AC);
  static const green = Color(0xFF20D0c4);
  static const dark = Color(0xFF03091E);
  static const grey = Color(0xFF212738);
  static const lightGrey = Color(0xFFBBBBBB);
  static const veryLightGrey = Color(0xFFF3F3F3);
  static const white = Color(0xFFFFFFFF);
  static const pink = Color(0xFFF5638B);
}

final deliveryGradients = [
  DeliveryColors.green,
  DeliveryColors.purple,
];

final _borderLight = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      color: DeliveryColors.veryLightGrey,
      width: 2,
      style: BorderStyle.solid,
    ));

final _borderDark = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(
      color: DeliveryColors.grey,
      width: 2,
      style: BorderStyle.solid,
    ));

final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: DeliveryColors.white,
      toolbarTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              titleLarge: const TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.purple,
                  fontWeight: FontWeight.bold))
          .bodyMedium,
      titleTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              titleLarge: const TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.purple,
                  fontWeight: FontWeight.bold))
          .titleLarge,
    ),
    colorScheme: const ColorScheme.dark(background: DeliveryColors.purple),
    bottomAppBarTheme:
        const BottomAppBarTheme(color: DeliveryColors.veryLightGrey),
    canvasColor: DeliveryColors.white,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.purple, displayColor: DeliveryColors.purple),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        border: _borderLight,
        labelStyle: const TextStyle(color: DeliveryColors.purple),
        enabledBorder: _borderLight,
        focusedBorder: _borderLight,
        hintStyle: GoogleFonts.poppins(
          color: DeliveryColors.lightGrey,
          fontSize: 10,
        )),
    iconTheme: const IconThemeData(
      color: DeliveryColors.purple,
    ));

final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: DeliveryColors.purple,
      toolbarTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              titleLarge: const TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.white,
                  fontWeight: FontWeight.bold))
          .bodyMedium,
      titleTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              titleLarge: const TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.white,
                  fontWeight: FontWeight.bold))
          .titleLarge,
    ),
    colorScheme: const ColorScheme.dark(background: DeliveryColors.white),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.transparent),
    canvasColor: DeliveryColors.grey,
    scaffoldBackgroundColor: DeliveryColors.dark,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.green, displayColor: DeliveryColors.green),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: DeliveryColors.white),
        contentPadding: EdgeInsets.zero,
        border: _borderDark,
        enabledBorder: _borderDark,
        focusedBorder: _borderDark,
        fillColor: DeliveryColors.grey,
        filled: true,
        hintStyle: GoogleFonts.poppins(
          color: DeliveryColors.white,
          fontSize: 10,
        )),
    iconTheme: const IconThemeData(
      color: DeliveryColors.white,
    ));
