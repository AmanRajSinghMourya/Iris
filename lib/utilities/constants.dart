import 'package:flutter/material.dart';

TextStyle kLoginTitleStyle(Size size) => TextStyle(
      fontSize: size.height * 0.055,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Roboto', // Use any default font family if needed
    );

TextStyle kLoginSubtitleStyle(Size size) => TextStyle(
      fontSize: size.height * 0.030,
      color: Colors.white,
      fontFamily: 'Roboto', // Use any default font family if needed
    );

TextStyle kLoginTermsAndPrivacyStyle(Size size) => TextStyle(
      fontSize: 15,
      color: Colors.white70,
      height: 1.5,
      fontFamily: 'Roboto', // Use any default font family if needed
    );

TextStyle kHaveAnAccountStyle(Size size) => TextStyle(
      fontSize: size.height * 0.022,
      color: Colors.white,
      fontFamily: 'Roboto', // Use any default font family if needed
    );

TextStyle kLoginOrSignUpTextStyle(Size size) => TextStyle(
      fontSize: size.height * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.deepPurpleAccent,
      fontFamily: 'Roboto', // Use any default font family if needed
    );

TextStyle kTextFormFieldStyle() => const TextStyle(
      color: Colors.white,
    );

TextStyle kButtonStyle() => const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    );

TextStyle kHintTextStyle() => TextStyle(
      color: Colors.white.withOpacity(0.7),
    );

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
