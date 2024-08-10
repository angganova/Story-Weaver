import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../system/global_style.dart';
import '../../../system/variables/var_style.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.textStyle,
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.floatingLabel = false,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.showObscureOption = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.isDense,
    this.textInputAction,
    this.prefixSvg,
    this.trailing,
    this.textInputType,
    this.textCapitalization,
    this.validator,
    this.maxLength,
    this.maxLine,
    this.scrollPadding,
    this.singleLine = true,
    this.obscure,
    this.leadingText,
    this.inputFormatters,
    this.floatingLabelStyle,
    this.labelStyle,
    this.contentPadding,
    this.noBorder = false,
    this.underlineBorder = false,
    this.enable = true,
    this.borderColor = AppColors.gray,
    this.fillColor = AppColors.grayLight,
    this.borderRadius = kBorderRadiusAll8,
    this.errorStyle,
    this.isFilled = true,
    this.disableCounterText = true,
    this.leadingTextStyle,
    this.textAlign = TextAlign.start,
    this.errorText,
    this.autofillHints,
    this.autovalidateMode,
    this.onSuffixClick,
    this.prefixIconData,
    this.prefixColor,
  });

  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final String? labelText;
  final String? hintText;
  final bool floatingLabel;
  final bool showObscureOption;
  final bool autoFocus;
  final bool? isDense;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final VoidCallback? onTap;
  final Function(String s)? onChanged;
  final Function(String s)? onFieldSubmitted;
  final String? prefixSvg;
  final IconData? prefixIconData;
  final Color? prefixColor;
  final String? leadingText;
  final Widget? trailing;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool enable;
  final int? maxLength;
  final int? maxLine;
  final bool? singleLine;
  final bool? obscure;
  final EdgeInsets? scrollPadding;
  final EdgeInsets? contentPadding;
  final Color fillColor;
  final bool noBorder;
  final bool underlineBorder;
  final Color borderColor;
  final BorderRadius borderRadius;
  final bool isFilled;
  final bool disableCounterText;
  final TextStyle? leadingTextStyle;
  final TextAlign textAlign;
  final String? errorText;
  final dynamic autofillHints;
  final AutovalidateMode? autovalidateMode;
  final Function()? onSuffixClick;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.showObscureOption) {
      setState(() => _obscureText = true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final InputBorder inputBorder = widget.underlineBorder
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
          )
        : OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
            borderRadius: widget.borderRadius,
          );

    return TextFormField(
      style: widget.textStyle ?? AppTextStyle.instance.formInput,
      obscureText: widget.obscure ?? _obscureText,
      maxLength: widget.maxLength,
      maxLines: (widget.singleLine ?? false) ? 1 : widget.maxLine,
      minLines: (widget.singleLine ?? false) ? 1 : null,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          isDense: widget.isDense ?? false,
          prefixText: widget.leadingText,
          prefixStyle: widget.leadingTextStyle,
          prefixIcon: widget.prefixIconData != null
              ? Icon(
                  widget.prefixIconData,
                  color: widget.prefixColor ?? AppColors.textColorGrayAccent,
                )
              : null,
          fillColor: widget.fillColor,
          filled: widget.isFilled,
          suffixIcon: widget.trailing != null
              ? GestureDetector(
                  onTap: widget.onSuffixClick,
                  child: widget.trailing,
                )
              : (!widget.showObscureOption
                  ? null
                  : GestureDetector(
                      onTap: () => setState(
                        () => _obscureText = !_obscureText,
                      ),
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    )),
          focusColor: AppColors.black,
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              AppTextStyle.instance.paragraph.copyWith(
                color: AppColors.textColorGrayAccent,
              ),
          floatingLabelBehavior: widget.floatingLabel
              ? FloatingLabelBehavior.never
              : widget.floatingLabel
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto,
          counterText: widget.disableCounterText ? '' : null,
          contentPadding: widget.contentPadding ??
              AppSpacer.instance.edgeInsets.symmetric(x: 'xs', y: 'xxs'),
          labelStyle: widget.labelStyle ??
              AppTextStyle.instance.label.copyWith(color: AppColors.black),
          floatingLabelStyle: widget.floatingLabelStyle,
          counterStyle: widget.textStyle ?? AppTextStyle.instance.formInput,
          errorText: widget.errorText,
          errorStyle: widget.errorStyle ??
              AppTextStyle.instance.label.copyWith(color: AppColors.errorColor),
          disabledBorder: widget.noBorder ? InputBorder.none : inputBorder,
          enabledBorder: widget.noBorder
              ? InputBorder.none
              : inputBorder.copyWith(
                  borderSide: BorderSide(color: widget.borderColor)),
          focusedBorder: widget.noBorder
              ? InputBorder.none
              : inputBorder.copyWith(
                  borderSide: BorderSide(color: widget.borderColor)),
          errorBorder: widget.noBorder ? InputBorder.none : inputBorder,
          border: widget.noBorder ? InputBorder.none : inputBorder),
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      enabled: widget.enable,
      scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
    );
  }
}

class CommaSeparatedTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    if (newValue.text.compareTo(oldValue.text) == 0) {
      return newValue;
    }

    final String stringValue =
        formatCurrency(newValue.text.replaceAll(',', ''));
    final int selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;
    final int currentIndex = stringValue.length - selectionIndexFromTheRight;
    return TextEditingValue(
      text: stringValue,
      selection: TextSelection.collapsed(offset: currentIndex),
    );
  }

  String formatCurrency(String value) {
    final List<String> numbers = value.split('.');
    String stringValue = formatSeparator(numbers[0]);
    if (numbers.length == 2) {
      stringValue = '$stringValue.${numbers[1]}';
    }
    return stringValue;
  }

  String formatSeparator(String integerPart) {
    final NumberFormat numberFormat = NumberFormat('#,###');
    return numberFormat.format(int.parse(integerPart));
  }
}

class ThousandTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final NumberFormat f = NumberFormat('#,###');
      final int number =
          int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final String newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

class ThousandWithDecimalTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.contains(RegExp(',\$'))) {
      return newValue;
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final NumberFormat f = NumberFormat('#,###.##');
      final double number = double.parse(newValue.text
          .replaceAll(f.symbols.GROUP_SEP, '')
          .replaceAll(',', '.')
          .toString());
      final String newString = f.format(number);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
