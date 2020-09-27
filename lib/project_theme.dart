import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTheme {
  static Color projectPrimaryColor = Color.fromARGB(255, 228, 109, 109);
  static Color projectSecondryColor = Color.fromARGB(255, 255, 140, 140);
  static Color projectPrimaryTextColor = Color.fromARGB(255, 210, 100, 100);
  static Color projectSecondryTextColor = Colors.brown;
  static Color projectTextColorlight = Colors.blueGrey;
  static Color textFieldHintColor = Colors.grey;
  static Color projectBackgroundColor = Colors.white;


  static TextStyle buttonFontAndStyle = GoogleFonts.lora(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold));

  static TextStyle headingFontAndStyle = GoogleFonts.lora(
      textStyle: TextStyle(
          color: projectPrimaryTextColor,
          fontSize: 30,
          fontWeight: FontWeight.bold));

  static TextStyle subHeadingFontAndStyle = GoogleFonts.lora(
      color: projectSecondryTextColor, textStyle: TextStyle(fontSize: 20));

  static TextStyle simpleTextFontAndStyle = GoogleFonts.lora(
      color: projectTextColorlight, textStyle: TextStyle(fontSize: 20));

  static TextStyle simpleTextFontAndStyleLight = GoogleFonts.lora(
      color: textFieldHintColor, textStyle: TextStyle(fontSize: 20));

  static TextStyle textFontAndStyle = GoogleFonts.lora(
      color: projectSecondryTextColor, textStyle: TextStyle(fontSize: 15));

  static TextStyle textFontAndStyleLight = GoogleFonts.lora(
      color: projectTextColorlight, textStyle: TextStyle(fontSize: 15));

  static BoxShadow secondryShadow =
      BoxShadow(color: Colors.grey.shade400, spreadRadius: 0.2, blurRadius: 10);

  static BoxShadow primaryShadow =
      BoxShadow(color: projectPrimaryColor, spreadRadius: 2, blurRadius: 10);

  static BoxDecoration boxBackgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        projectPrimaryColor.withOpacity(0.025),
        projectSecondryColor.withOpacity(0.1)
      ],
    ),
    borderRadius: BorderRadius.circular(15),
  );
}
