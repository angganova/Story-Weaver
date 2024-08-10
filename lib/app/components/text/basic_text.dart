import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../system/global_style.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.textStyle,
    this.fontWeight,
    this.overflow = TextOverflow.ellipsis,
    this.money = false,
    this.number = false,
    this.decoration = TextDecoration.none,
    this.maxLines = 3,
    this.align = TextAlign.left,
    this.isBold = false,
    this.color,
    this.isItalic = false,
    this.lineHeight = 1.2,
    this.letterSpacing = 0,
  });

  factory AppText.hero(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.hero,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.title(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.title,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.mega(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.mega,
      align: textAlign,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
    );
  }

  factory AppText.h1(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.h1,
      align: textAlign,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
    );
  }

  factory AppText.h2(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    int? maxLines,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.h2Medium,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
      maxLines: maxLines,
    );
  }

  factory AppText.h3(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    double? lineHeight,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.h3,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      lineHeight: lineHeight,
    );
  }

  factory AppText.h4(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    double lineHeight = 1.2,
    int? maxLines,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.h4,
      color: color,
      isBold: isBold,
      align: align,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
      maxLines: maxLines,
    );
  }

  factory AppText.headline(
    String text, {
    Color color = AppColors.textBlack,
    int? maxLines,
    TextAlign? align,
    FontWeight? fontWeight,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.headline.copyWith(
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
      color: color,
      maxLines: maxLines,
      align: align,
    );
  }

  factory AppText.sectionHeader(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = true,
    int? maxLines,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.sectionHeader,
      color: color,
      isBold: isBold,
      maxLines: maxLines,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.formInput(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    double? lineHeight,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.formInput,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      lineHeight: lineHeight,
    );
  }

  factory AppText.b1(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.b1,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.b1Center(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.b1,
      color: color,
      isBold: isBold,
      align: TextAlign.center,
      fontWeight: fontWeight,
    );
  }

  factory AppText.b2(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.b2,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.paragraph(
    String text, {
    Color? color = AppColors.textBlack,
    bool isBold = false,
    int maxLines = 3,
    TextAlign? align,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.paragraph.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      maxLines: maxLines,
      align: align,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
      decoration: decoration,
    );
  }

  factory AppText.paragraph2(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    int maxLines = 3,
    TextAlign? align,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.paragraph2.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      maxLines: maxLines,
      align: align,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
      decoration: decoration,
    );
  }

  factory AppText.paragraph3(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    int maxLines = 3,
    TextAlign? align,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.paragraph3.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      maxLines: maxLines,
      align: align,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
      decoration: decoration,
    );
  }

  factory AppText.label(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w400,
    int maxLines = 3,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight = 1.2,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
      decoration: decoration,
      lineHeight: lineHeight,
      align: align,
    );
  }

  factory AppText.label1(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w400,
    int maxLines = 3,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight = 1.2,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label1.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
      decoration: decoration,
      lineHeight: lineHeight,
      align: align,
    );
  }

  factory AppText.label2(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w500,
    int maxLines = 3,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight = 1.2,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label2.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
      decoration: decoration,
      lineHeight: lineHeight,
      align: align,
    );
  }

  factory AppText.label3Medium(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w400,
    int maxLines = 3,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight = 1.2,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label3Medium.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
      decoration: decoration,
      lineHeight: lineHeight,
      align: align,
    );
  }

  factory AppText.label3SemiBold(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w400,
    int maxLines = 3,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight = 1.2,
    TextAlign? align,
    TextOverflow? overflow,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label3SemiBold.copyWith(
        overflow: overflow,
      ),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      maxLines: maxLines,
      decoration: decoration,
      lineHeight: lineHeight,
      align: align,
    );
  }

  factory AppText.labelCenter(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight fontWeight = FontWeight.w400,
    int maxLines = 3,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.label,
      color: color,
      isBold: isBold,
      align: TextAlign.center,
      fontWeight: fontWeight,
      maxLines: maxLines,
    );
  }

  factory AppText.caption(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    TextAlign? align,
    FontWeight? fontWeight,
    int maxLines = 3,
    double? lineHeight,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.caption,
      color: color,
      isBold: isBold,
      align: align,
      fontWeight: fontWeight,
      maxLines: maxLines,
      lineHeight: lineHeight,
    );
  }

  factory AppText.badge(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    int? maxLines,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.badge,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
      maxLines: maxLines,
    );
  }

  factory AppText.smallest(
    String text, {
    Color color = AppColors.textBlack,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.smallest,
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
    );
  }

  factory AppText.freeStyle(
    String text, {
    Color? color,
    double? fontSize,
    bool isBold = false,
    FontWeight? fontWeight,
    TextAlign? align,
    int? maxLines,
    TextOverflow? overflow,
    double? lineHeight,
    TextDecoration? decoration,
  }) {
    return AppText(
      text,
      textStyle: AppTextStyle.instance.freeStyle(size: fontSize),
      color: color,
      isBold: isBold,
      fontWeight: fontWeight,
      align: align,
      maxLines: maxLines,
      overflow: overflow,
      lineHeight: lineHeight,
      decoration: decoration,
    );
  }
  final String text;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? align;
  final bool? money;
  final bool? number;
  final TextDecoration? decoration;
  final int? maxLines;
  final Color? color;
  final bool isBold, isItalic;
  final double? lineHeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: (textStyle ?? AppTextStyle.instance.paragraph).copyWith(
        inherit: true,
        color: color ?? AppColors.textBlack,
        fontWeight: isBold ? FontWeight.w600 : fontWeight,
        decoration: decoration,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        height: lineHeight,
        letterSpacing: letterSpacing,
      ),
      overflow: overflow,
      textAlign: align,
      maxLines: maxLines,
    );
  }
}

class AppRichText extends StatelessWidget {
  const AppRichText({
    required this.children,
    this.textStyle,
    this.overflow = TextOverflow.clip,
    this.decoration = TextDecoration.none,
    this.maxLines,
    this.align = TextAlign.justify,
    this.isItalic = false,
    this.lineHeight = 1.5,
    super.key,
  });
  final List<InlineSpan>? children;
  final TextStyle? textStyle;
  final TextOverflow overflow;
  final TextAlign align;
  final TextDecoration decoration;
  final int? maxLines;
  final bool isItalic;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: (textStyle ?? AppTextStyle.instance.paragraph).copyWith(
          /// Use this Theme.of(context).textTheme.headline3?.color to support
          /// dynamic theme
          decoration: decoration,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          height: lineHeight,
        ),
        children: children,
      ),
      overflow: overflow,
      textAlign: align,
      maxLines: maxLines,
    );
  }
}

TextSpan appTextSpan({
  required String text,
  Color? color,
  TextStyle? textStyle,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  double lineHeight = 1.5,
  bool isItalic = false,
  GestureRecognizer? gestureRecognizer,
}) {
  return TextSpan(
    style: (textStyle ?? AppTextStyle.instance.paragraph).copyWith(
      inherit: true,
      color: color,
      fontWeight: fontWeight,
      decoration: decoration,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      height: lineHeight,
    ),
    text: text,
    recognizer: gestureRecognizer,
  );
}
