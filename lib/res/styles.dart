import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyle {
  static final TextStyle btnSignInGoogle = GoogleFonts.roboto(
    textStyle: TextStyle(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  static final TextStyle btnPrimary = GoogleFonts.roboto(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle cardTitleTrue = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.blackGrey,
      fontSize: 25,
    fontWeight: FontWeight.w500,
    ),
  );

  static final TextStyle cardTitleFalse = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCream,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
  );

  static final TextStyle cardContentTrue = GoogleFonts.openSans(
    textStyle: TextStyle(
        color: CustomColors.blackGrey,
        fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle cardContentFalse = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCream,
      fontSize: 30,
      fontWeight: FontWeight.w700
    ),
  );

  static final TextStyle popUpTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
        color: CustomColors.blackGrey,
        fontSize: 30,
        fontWeight: FontWeight.w700
    ),
  );

  static final TextStyle popUpSubtitle = GoogleFonts.openSansCondensed(
    textStyle: TextStyle(
        color: CustomColors.blackGrey,
        fontSize: 15,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600
    ),
  );

  static final TextStyle popUpValue = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.blackGrey,
      fontSize: 35,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle popUpContent = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.blackGrey,
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
  );

  static final TextStyle navbarMenu = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.blackGrey,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
  );

  static final TextStyle appBarTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle mainTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.colorAccent,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );

  static final TextStyle pageTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.colorAccent,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle userName = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle userEmail = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );

  static final TextStyle circleProgressTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 50,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle circleProgressDetail = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle appDescription = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
  );

  static final TextStyle statusFalseTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.colorAccent,
      fontSize: 35,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle statusTrueTitle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.blackGrey,
      fontSize: 35,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle statusTrue = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
  );

  static final TextStyle statusFalse = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: CustomColors.whiteCreamOri,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    ),
  );

}

class CustomColors {
  static final Color firebaseOrange = Color(0xFFF57C00);
  static final Color firebaseGrey = Color(0xFFECEFF1);
  static final Color whiteCreamOri = Color(0xFFE6E3E0);
  static final Color blackGrey = Color(0xFF2A2A2A);
  static final Color colorAccent = Color(0xFF4468C5);
  static final Color whiteCream = Color(0xFFF4F1EE);
  static final Color colorAccent2 = Color(0xFF1F3B83);
}