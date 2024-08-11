import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/service/local_storage.dart';

/// Main Text Style Class
/// Letter Spacing : convert [em] to [px]
class AppTextStyle {
  factory AppTextStyle() => instance;

  AppTextStyle._();

  ///Singleton factory
  static final AppTextStyle instance = AppTextStyle._();

  void init() {
    currentTextStyle = storageTextStyle;
    currentTextScaleFactor = storageTextScale;
  }

  List<TextStyle> availableTextStyle = [
    GoogleFonts.aBeeZee(),
    GoogleFonts.merriweather(),
    GoogleFonts.lora(),
    GoogleFonts.caveat(),
    GoogleFonts.spaceGrotesk(),
    GoogleFonts.dancingScript(),
    GoogleFonts.signikaNegative(),
    GoogleFonts.mPlusRounded1c(),
    GoogleFonts.indieFlower(),
    GoogleFonts.ubuntu(),
    GoogleFonts.playfairDisplay(),
    GoogleFonts.oswald(),
    GoogleFonts.exo2(),
    GoogleFonts.lobster(),
    GoogleFonts.greyQo(),
    GoogleFonts.cinzel(),
    GoogleFonts.greatVibes(),
    GoogleFonts.raleway(),
    GoogleFonts.ptSerif(),
    GoogleFonts.bebasNeue(),
    GoogleFonts.montserrat(),
    GoogleFonts.robotoMono(),
    GoogleFonts.pacifico(),
  ];

  List<double> availableTextScale = [
    1,
    1.25,
    1.5,
    2,
  ];

  TextStyle get storageTextStyle {
    String fontName = AppLocalStorage.instance.getTextStyleName;
    List<TextStyle> selectedTextStyleList = availableTextStyle
        .where((item) => item.fontFamily.ignoreCaseIgnoreSpace(fontName))
        .toList();
    if (selectedTextStyleList.length.isMoreThanZero) {
      currentTextStyle = selectedTextStyleList.first;
    }
    return currentTextStyle;
  }

  double get storageTextScale {
    double textScale = AppLocalStorage.instance.getTextScale;
    currentTextScaleFactor = textScale;
    return currentTextScaleFactor;
  }

  TextStyle currentTextStyle = GoogleFonts.aBeeZee();
  double currentTextScaleFactor = 1;

  Color defaultTextColor = Colors.black;

  /// Free Text Style
  TextStyle freeStyle({Color? color, double? size}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: size ?? 12 * currentTextScaleFactor);

  /// App text style as described in the design system
  TextStyle get hero =>
      defaultHeaderTextStyle.copyWith(fontSize: 80 * currentTextScaleFactor);

  TextStyle get title =>
      defaultNormalTextStyle.copyWith(fontSize: 64 * currentTextScaleFactor);

  TextStyle get mega =>
      defaultNormalTextStyle.copyWith(fontSize: 24 * currentTextScaleFactor);

  TextStyle get titleHeading1 =>
      defaultNormalTextStyle.copyWith(fontSize: 32 * currentTextScaleFactor);

  TextStyle get titleHeading2 =>
      defaultNormalTextStyle.copyWith(fontSize: 48 * currentTextScaleFactor);

  TextStyle get h1 => defaultHeaderTextStyle.copyWith(
        fontSize: 18 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h2Medium => defaultHeaderTextStyle.copyWith(
        fontSize: 16 * currentTextScaleFactor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get h2SemiBold => h2Medium.copyWith(
        fontSize: 16 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h3 => defaultHeaderTextStyle.copyWith(
        fontSize: 14 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get h4 => defaultHeaderTextStyle.copyWith(
        fontSize: 12 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline =>
      defaultNormalTextStyle.copyWith(fontSize: 18 * currentTextScaleFactor);

  TextStyle get sectionHeader => defaultNormalTextStyle.copyWith(
      fontSize: 16 * currentTextScaleFactor,
      letterSpacing: 0.03,
      fontWeight: FontWeight.w600);

  TextStyle get formInput =>
      defaultNormalTextStyle.copyWith(fontSize: 16 * currentTextScaleFactor);

  TextStyle get b1 => defaultNormalTextStyle.copyWith(
      fontSize: 14 * currentTextScaleFactor, height: 1.5);

  TextStyle get b2 => defaultNormalTextStyle.copyWith(
      fontSize: 12 * currentTextScaleFactor, height: 1.5);

  TextStyle get paragraph =>
      defaultNormalTextStyle.copyWith(fontSize: 14 * currentTextScaleFactor);

  TextStyle get paragraph2 =>
      defaultNormalTextStyle.copyWith(fontSize: 12 * currentTextScaleFactor);

  TextStyle get paragraph3 =>
      defaultNormalTextStyle.copyWith(fontSize: 11 * currentTextScaleFactor);

  TextStyle get label =>
      defaultNormalTextStyle.copyWith(fontSize: 12 * currentTextScaleFactor);

  TextStyle get label1 =>
      defaultNormalTextStyle.copyWith(fontSize: 16 * currentTextScaleFactor);

  TextStyle get label2 => defaultNormalTextStyle.copyWith(
        fontSize: 14 * currentTextScaleFactor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label3Medium => defaultNormalTextStyle.copyWith(
        fontSize: 12 * currentTextScaleFactor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get label3SemiBold => defaultNormalTextStyle.copyWith(
        fontSize: 12 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get label4 => defaultNormalTextStyle.copyWith(
        fontSize: 1 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get label5Medium => defaultNormalTextStyle.copyWith(
        fontSize: 10 * currentTextScaleFactor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label5SemiBold => defaultNormalTextStyle.copyWith(
        fontSize: 10 * currentTextScaleFactor,
        fontWeight: FontWeight.w700,
      );

  TextStyle get caption =>
      defaultNormalTextStyle.copyWith(fontSize: 11 * currentTextScaleFactor);

  TextStyle get badge =>
      defaultNormalTextStyle.copyWith(fontSize: 10 * currentTextScaleFactor);

  TextStyle get smallest =>
      defaultNormalTextStyle.copyWith(fontSize: 8 * currentTextScaleFactor);

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
      fontSize: 15 * currentTextScaleFactor);

  TextStyle get defaultNormalTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      height: 1.2,
      fontSize: 15 * currentTextScaleFactor);

  TextStyle get defaultBoldTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      height: 1.2,
      letterSpacing: -0.32 * currentTextScaleFactor,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      fontSize: 19 * currentTextScaleFactor);

  TextStyle get defaultSemiBoldTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      height: 1.2,
      letterSpacing: 0 * currentTextScaleFactor,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 19 * currentTextScaleFactor);

  TextStyle get defaultItalicTextStyle => currentTextStyle.copyWith(
      color: defaultTextColor,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
      fontSize: 19 * currentTextScaleFactor);
}
