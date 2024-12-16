import 'package:bustracking/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:bustracking/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:bustracking/src/utils/theme/widget_themes/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  static ThemeData lighttheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TTextTheme.lighttextTheme,
      primarySwatch: Colors.deepPurple,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
  );
  static ThemeData darktheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: TTextTheme.darktextTheme,
      primarySwatch: Colors.deepPurple,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),

  );
}

/*ThemeData(
brightness: Brightness.light,
colorScheme: ColorScheme.light(
primary: Colors.deepPurpleAccent, // Set the primary color of the color scheme
onPrimary: Colors.white, // Set the text color for the primary color
),
textTheme: TextTheme(
bodySmall: TextStyle(color: Colors.black),
headline2: GoogleFonts.montserrat(
color: Colors.black87,
),
subtitle2: GoogleFonts.poppins(
color: Colors.black87,
fontSize: 24,
),// Set the color of the month and year text
),
primarySwatch: MaterialColor(
        0xFF6200EA,
      <int, Color>{
        100: Color(0xFFB388FF),
        200: Color(0xFF7C4DFF),
        400: Color(0xFF651FFF),
        700: Color(0xFF6200EA),
      },),
),*/
