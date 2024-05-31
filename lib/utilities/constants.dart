import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.060,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
      fontSize: size.height * 0.030,
      color: Colors.white,
    );

TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: 15, color: Colors.white70, height: 1.5);

TextStyle kHaveAnAccountStyle(Size size) =>
    GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.white);

TextStyle kLoginOrSignUpTextStyle(
  Size size,
) =>
    GoogleFonts.ubuntu(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.deepPurpleAccent,
    );

TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.white);

TextStyle kButtonStyle() => const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    );

TextStyle kHintTextStyle() => TextStyle(color: Colors.white.withOpacity(0.7));

InputBorder kFocusedBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.7),
      ),
    );

const kBackgroundColor = Color(0xFF171821);
final kIconColor = Colors.white.withOpacity(0.7);

const primaryColorCode = 0xFFA9DFD8;
const cardBackgroundColor = Color(0xFF21222D);
//0xFFA9DFD8;

