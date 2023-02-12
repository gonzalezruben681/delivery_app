import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        AppBarTheme,
        BorderRadius,
        BorderSide,
        Color,
        ColorScheme,
        Colors,
        InputDecorationTheme,
        OutlineInputBorder,
        TextTheme,
        ThemeData;
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  static final purple = Color(0xFF5117AC);
  static final green = Color(0xFF20D0c4);
  static final dark = Color(0xFF03091E);
  static final grey = Color(0xFF212738);
  static final lightGrey = Color(0xFFBBBBBB);
  static final veryLightGrey = Color(0xFFF3F3F3);
  static final white = Color(0xFFFFFFFF);
  static final pink = Color(0xFFF5638B);
}

final deliveryGradients = [
  DeliveryColors.green,
  DeliveryColors.purple,
];

final _borderLight = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: DeliveryColors.veryLightGrey,
      width: 2,
      style: BorderStyle.solid,
    ));

final _borderDark = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: DeliveryColors.grey,
      width: 2,
      style: BorderStyle.solid,
    ));

final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: DeliveryColors.white,
      toolbarTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              headline6: TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.purple,
                  fontWeight: FontWeight.bold))
          .bodyText2,
      titleTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              headline6: TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.purple,
                  fontWeight: FontWeight.bold))
          .headline6,
    ),
    colorScheme: ColorScheme.dark(background: DeliveryColors.purple),
    bottomAppBarColor: DeliveryColors.veryLightGrey,
    canvasColor: DeliveryColors.white,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.purple, displayColor: DeliveryColors.purple),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        border: _borderLight,
        labelStyle: TextStyle(color: DeliveryColors.purple),
        enabledBorder: _borderLight,
        focusedBorder: _borderLight,
        hintStyle: GoogleFonts.poppins(
          color: DeliveryColors.lightGrey,
          fontSize: 10,
        )),
    iconTheme: IconThemeData(
      color: DeliveryColors.purple,
    ));

final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: DeliveryColors.purple,
      toolbarTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              headline6: TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.white,
                  fontWeight: FontWeight.bold))
          .bodyText2,
      titleTextStyle: GoogleFonts.poppinsTextTheme()
          .copyWith(
              headline6: TextStyle(
                  fontSize: 20,
                  color: DeliveryColors.white,
                  fontWeight: FontWeight.bold))
          .headline6,
    ),
    colorScheme: ColorScheme.dark(background: DeliveryColors.white),
    bottomAppBarColor: Colors.transparent,
    canvasColor: DeliveryColors.grey,
    scaffoldBackgroundColor: DeliveryColors.dark,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: DeliveryColors.green, displayColor: DeliveryColors.green),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: DeliveryColors.white),
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
    iconTheme: IconThemeData(
      color: DeliveryColors.white,
    ));
