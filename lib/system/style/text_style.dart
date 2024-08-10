import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_weaver/system/utils/data_utils.dart';

/// Main Text Style Class
/// Letter Spacing : convert [em] to [px]
class AppTextStyle {
  factory AppTextStyle() => instance;

  AppTextStyle._();

  ///Singleton factory
  static final AppTextStyle instance = AppTextStyle._();

  void init() {
    currentTextStyle = availableTextStyle[
        DataUtils.generateRandomNumber(0, availableTextStyle.length - 1)];
  }

  List<TextStyle> availableTextStyle = [
    GoogleFonts.aBeeZee(),
    GoogleFonts.merriweather(),
    GoogleFonts.lora(),
    GoogleFonts.spaceGrotesk(),
    GoogleFonts.mPlusRounded1c(),
    GoogleFonts.ubuntu(),
    GoogleFonts.oswald(),
  ];

  TextStyle currentTextStyle = GoogleFonts.aBeeZee();

  Color defaultTextColor = Colors.black;
  double defaultTextScaleFactor = 1;

  /// Free Text Style
  TextStyle freeStyle({Color? color, double? size}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: size ?? 12 * defaultTextScaleFactor);

  /// App text style as described in the design system
  TextStyle get hero =>
      defaultHeaderTextStyle.copyWith(fontSize: 80 * defaultTextScaleFactor);

  TextStyle get title =>
      defaultNormalTextStyle.copyWith(fontSize: 64 * defaultTextScaleFactor);

  TextStyle get mega =>
      defaultNormalTextStyle.copyWith(fontSize: 24 * defaultTextScaleFactor);

  TextStyle get titleHeading1 =>
      defaultNormalTextStyle.copyWith(fontSize: 32 * defaultTextScaleFactor);

  TextStyle get titleHeading2 =>
      defaultNormalTextStyle.copyWith(fontSize: 48 * defaultTextScaleFactor);

  TextStyle get h1 => defaultHeaderTextStyle.copyWith(
        fontSize: 18 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h2Medium => defaultHeaderTextStyle.copyWith(
        fontSize: 16 * defaultTextScaleFactor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get h2SemiBold => h2Medium.copyWith(
        fontSize: 16 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h3 => defaultHeaderTextStyle.copyWith(
        fontSize: 14 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h4 => defaultHeaderTextStyle.copyWith(
        fontSize: 12 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline =>
      defaultNormalTextStyle.copyWith(fontSize: 18 * defaultTextScaleFactor);

  TextStyle get sectionHeader => defaultNormalTextStyle.copyWith(
      fontSize: 16 * defaultTextScaleFactor,
      letterSpacing: 0.03,
      fontWeight: FontWeight.w600);

  TextStyle get formInput =>
      defaultNormalTextStyle.copyWith(fontSize: 16 * defaultTextScaleFactor);

  TextStyle get b1 => defaultNormalTextStyle.copyWith(
      fontSize: 14 * defaultTextScaleFactor, height: 1.5);

  TextStyle get b2 => defaultNormalTextStyle.copyWith(
      fontSize: 12 * defaultTextScaleFactor, height: 1.5);

  TextStyle get paragraph =>
      defaultNormalTextStyle.copyWith(fontSize: 14 * defaultTextScaleFactor);

  TextStyle get paragraph2 =>
      defaultNormalTextStyle.copyWith(fontSize: 12 * defaultTextScaleFactor);

  TextStyle get paragraph3 =>
      defaultNormalTextStyle.copyWith(fontSize: 11 * defaultTextScaleFactor);

  TextStyle get label =>
      defaultNormalTextStyle.copyWith(fontSize: 12 * defaultTextScaleFactor);

  TextStyle get label1 =>
      defaultNormalTextStyle.copyWith(fontSize: 16 * defaultTextScaleFactor);

  TextStyle get label2 => defaultNormalTextStyle.copyWith(
        fontSize: 14 * defaultTextScaleFactor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label3Medium => defaultNormalTextStyle.copyWith(
        fontSize: 12 * defaultTextScaleFactor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get label3SemiBold => defaultNormalTextStyle.copyWith(
        fontSize: 12 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get label4 => defaultNormalTextStyle.copyWith(
        fontSize: 1 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get label5Medium => defaultNormalTextStyle.copyWith(
        fontSize: 10 * defaultTextScaleFactor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label5SemiBold => defaultNormalTextStyle.copyWith(
        fontSize: 10 * defaultTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get caption =>
      defaultNormalTextStyle.copyWith(fontSize: 11 * defaultTextScaleFactor);

  TextStyle get badge =>
      defaultNormalTextStyle.copyWith(fontSize: 10 * defaultTextScaleFactor);

  TextStyle get smallest =>
      defaultNormalTextStyle.copyWith(fontSize: 8 * defaultTextScaleFactor);

  /// Advanced Text Style
  TextStyle get boldParagraph => paragraph.copyWith(
        fontWeight: FontWeight.w700,
      );

  TextStyle get mediumLabel => label.copyWith(fontWeight: FontWeight.w500);
  TextStyle get semiBoldLabel => label.copyWith(fontWeight: FontWeight.w600);
  TextStyle get boldLabel => label.copyWith(fontWeight: FontWeight.w700);

  ///
  /// Default Style
  TextStyle get defaultHeaderTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      fontWeight: FontWeight.w600,
      height: 1.2,
      fontStyle: FontStyle.normal,
      fontSize: 15 * defaultTextScaleFactor);

  TextStyle get defaultNormalTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.2,
      fontSize: 15 * defaultTextScaleFactor);

  TextStyle get defaultBoldTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      height: 1.2,
      letterSpacing: -0.32 * defaultTextScaleFactor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 19 * defaultTextScaleFactor);

  TextStyle get defaultSemiBoldTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      height: 1.2,
      letterSpacing: 0 * defaultTextScaleFactor,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 19 * defaultTextScaleFactor);

  TextStyle get defaultItalicTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
      fontSize: 19 * defaultTextScaleFactor);
}
