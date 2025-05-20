import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  ///

  static TextStyle titleSmall = GoogleFonts.nunitoSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  ///
  static TextStyle titleMedium = GoogleFonts.nunitoSans(
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  ///
  static TextStyle titleLarge = GoogleFonts.nunitoSans(
    fontSize: 21,
    fontWeight: FontWeight.w500,
  );

  ///
  ///
  ///

  static TextStyle bodySmall = GoogleFonts.nunitoSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  ///
  static TextStyle bodyMedium = GoogleFonts.nunitoSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  ///
  static TextStyle bodyLarge = GoogleFonts.nunitoSans(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  ///
  static TextStyle headlineSmall = GoogleFonts.nunitoSans(
    fontSize: 19,
    fontWeight: FontWeight.w700,
  );

  ///
  static TextStyle headlineMedium = GoogleFonts.nunitoSans(
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );

  ///
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withValues(alpha: 0.1),
    spreadRadius: 10,
    blurRadius: 10,
    offset: const Offset(0, 3),
  );
}
