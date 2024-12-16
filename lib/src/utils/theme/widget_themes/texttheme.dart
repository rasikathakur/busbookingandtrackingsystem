import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme lighttextTheme = TextTheme(
    headline1: GoogleFonts.charm(
      color: Colors.grey[700],
      fontSize: 20,
    ),
    headline2: GoogleFonts.montserrat(
      color: Colors.blueGrey,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    headline3: GoogleFonts.montserrat(
      color: Colors.lightBlue[900],
      fontWeight: FontWeight.w900,
    ),
    headline4: GoogleFonts.aclonica(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    headline5: GoogleFonts.aclonica(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    headline6: GoogleFonts.charm(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    subtitle2: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 24,
    ),
    bodyText2:GoogleFonts.roboto(
      fontSize: 20,
      color: Colors.black87,
    ),

  );
  static TextTheme darktextTheme = TextTheme(
    headline1: GoogleFonts.charm(
      color: Colors.white70,
      fontSize: 20,
    ),
    headline2: GoogleFonts.montserrat(
      color: Colors.white70,
      fontSize: 25,
    ),
    headline3: GoogleFonts.montserrat(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
    ),
    headline4: GoogleFonts.aclonica(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    headline5: GoogleFonts.aclonica(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    headline6: GoogleFonts.charm(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    bodyText2:GoogleFonts.roboto(
      fontSize: 20,
      color: Colors.white70,
    ),
    subtitle2: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 24,
    ),
  );
}