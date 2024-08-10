import 'package:flutter/material.dart';

import '../../../system/global_style.dart';
import '../../../system/global_variable.dart';
import '../text/basic_text.dart';

enum AppButtonAnimationState { stateShrink, stateNormal, stateGrow }

class AppElevatedButton extends StatefulWidget {
  const AppElevatedButton({
    this.text = '',
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.textStyle,
    this.wrapContent = false,
    super.key,
    this.textAlign,
    this.leading,
    this.trailing,
    this.leadingPadding,
    this.trailingPadding,
    this.expandedText = false,
    this.isLoading = false,
    this.borderRadius,
  });

  factory AppElevatedButton.transparent({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    Color? textColor,
    EdgeInsetsGeometry? leadingPadding,
    bool expandedText = false,
    TextAlign? textAlign,
    bool isLoading = false,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      textColor: textColor ?? AppColors.textBlack,
      padding: padding,
      leading: leading,
      trailing: trailing,
      textStyle: textStyle,
      backgroundColor: AppColors.transparent,
      borderColor: AppColors.transparent,
      leadingPadding: leadingPadding,
      expandedText: expandedText,
      textAlign: textAlign,
      isLoading: isLoading,
    );
  }

  factory AppElevatedButton.primary({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    EdgeInsetsGeometry? leadingPadding,
    bool expandedText = false,
    TextAlign? textAlign,
    bool isLoading = false,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      textColor: AppColors.white,
      padding: padding,
      leading: leading,
      trailing: trailing,
      textStyle: textStyle,
      backgroundColor: AppColors.primaryColor,
      leadingPadding: leadingPadding,
      expandedText: expandedText,
      textAlign: textAlign,
      isLoading: isLoading,
    );
  }

  factory AppElevatedButton.subdued({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    EdgeInsetsGeometry? leadingPadding,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      backgroundColor: AppColors.buttonSubdued,
      textColor: AppColors.textPrimary,
      padding: padding,
      leading: leading,
      trailing: trailing,
      textStyle: textStyle,
      leadingPadding: leadingPadding,
    );
  }

  factory AppElevatedButton.selectable({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    bool isSelected = false,
    EdgeInsetsGeometry? leadingPadding,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      backgroundColor:
          isSelected ? AppColors.primaryColor : AppColors.buttonSubdued,
      textColor: isSelected ? AppColors.white : AppColors.textPrimary,
      padding: padding,
      leading: leading,
      trailing: trailing,
      textStyle: textStyle,
      leadingPadding: leadingPadding,
    );
  }

  factory AppElevatedButton.outlined({
    String? text,
    TextStyle? textStyle,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    EdgeInsetsGeometry? leadingPadding,
    Color color = AppColors.primaryColor,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      textStyle: textStyle,
      onPressed: onPressed,
      textColor: color,
      backgroundColor: AppColors.transparent,
      borderColor: color,
      padding: padding,
      leading: leading,
      trailing: trailing,
      leadingPadding: leadingPadding,
    );
  }

  factory AppElevatedButton.warning({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    EdgeInsetsGeometry? leadingPadding,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      textColor: AppColors.white,
      backgroundColor: AppColors.warningColor,
      borderColor: AppColors.white,
      padding: padding,
      leading: leading,
      trailing: trailing,
      leadingPadding: leadingPadding,
    );
  }

  factory AppElevatedButton.error({
    String? text,
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    EdgeInsetsGeometry? leadingPadding,
    TextStyle? textStyle,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text ?? '',
      onPressed: onPressed,
      textColor: AppColors.white,
      backgroundColor: AppColors.errorColor,
      borderColor: AppColors.errorColor,
      padding: padding,
      leading: leading,
      trailing: trailing,
      leadingPadding: leadingPadding,
      textStyle: textStyle,
    );
  }

  factory AppElevatedButton.custom({
    String text = '',
    VoidCallback? onPressed,
    bool wrapContent = false,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    TextStyle? textStyle,
    EdgeInsetsGeometry? leadingPadding,
    EdgeInsetsGeometry? trailingPadding,
    Color? textColor,
    Color? backgroundColor,
    Color? borderColor,
    TextAlign? textAlign,
    bool expandedText = false,
    BorderRadius? borderRadius,
  }) {
    return AppElevatedButton(
      wrapContent: wrapContent,
      text: text,
      onPressed: onPressed,
      textColor: textColor,
      padding: padding,
      leading: leading,
      trailing: trailing,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      leadingPadding: leadingPadding,
      trailingPadding: trailingPadding,
      borderColor: borderColor,
      textAlign: textAlign,
      expandedText: expandedText,
      borderRadius: borderRadius,
    );
  }
  final String text;
  final bool wrapContent;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget? trailing;
  final bool expandedText;
  final EdgeInsetsGeometry? leadingPadding;
  final EdgeInsetsGeometry? trailingPadding;
  final bool isLoading;
  final BorderRadius? borderRadius;

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  AppButtonAnimationState _animationState = AppButtonAnimationState.stateNormal;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: kDuration200);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: kDuration200,
      scale: buttonAnimationScale(_animationState),
      child: _mainView,
    );
  }

  Widget get _mainView {
    if (!widget.wrapContent) {
      return SizedBox(
        width: AppQuery.instance.width,
        child: buttonView,
      );
    } else {
      return buttonView;
    }
  }

  Widget get buttonView {
    if (widget.isLoading) {
      return ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(),
        ),
        label: AppText(
          widget.text,
          align: widget.textAlign ?? TextAlign.center,
          textStyle: widget.textStyle ?? AppTextStyle.instance.b1,
          color: widget.textColor ?? AppColors.white,
          fontWeight: widget.textStyle == null ? FontWeight.w500 : null,
        ),
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            widget.padding ?? AppSpacer.instance.edgeInsets.all.sm,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: widget.borderRadius ?? kBorderRadiusAll10),
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            widget.padding ?? AppSpacer.instance.edgeInsets.all.sm,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: widget.borderRadius ?? kBorderRadiusAll10),
          ),
          side: sideColor,
          backgroundColor: backgroundColor,
        ),
        child: _childView,
      );
    }
  }

  Widget get _childView {
    return Row(
      mainAxisSize: widget.wrapContent ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (widget.leading != null && widget.leadingPadding == null)
          widget.leading!
        else if (widget.leading != null && widget.leadingPadding != null)
          Padding(
            padding: widget.leadingPadding!,
            child: widget.leading,
          ),
        if (widget.expandedText) Expanded(child: _textView) else _textView,
        if (widget.trailing != null && widget.trailingPadding == null)
          widget.trailing ?? Container()
        else if (widget.trailing != null && widget.trailingPadding != null)
          Padding(
            padding: widget.trailingPadding!,
            child: widget.trailing,
          ),
      ],
    );
  }

  Widget get _textView {
    Color textColor = widget.textColor ?? AppColors.textWhite;

    if (widget.onPressed == null) {
      textColor = AppColors.textWhite;
    }

    return AppText(
      widget.text,
      align: widget.textAlign ?? TextAlign.center,
      textStyle: widget.textStyle ?? AppTextStyle.instance.b1,
      color: textColor,
      fontWeight: widget.textStyle == null ? FontWeight.w500 : null,
    );
  }

  WidgetStateProperty<BorderSide> get sideColor {
    if (widget.onPressed == null) {
      return WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: AppColors.transparent));
    } else if (widget.backgroundColor != null || widget.borderColor != null) {
      return WidgetStateProperty.all<BorderSide>(BorderSide(
          color:
              widget.borderColor ?? widget.backgroundColor ?? AppColors.white));
    } else {
      return WidgetStateProperty.all<BorderSide>(
          const BorderSide(color: AppColors.secondaryColor));
    }
  }

  WidgetStateProperty<Color> get backgroundColor {
    if (widget.onPressed == null) {
      return WidgetStateProperty.all<Color>(AppColors.buttonDisabledNew);
    } else if (widget.backgroundColor != null || widget.borderColor != null) {
      return WidgetStateProperty.all<Color>(
          widget.backgroundColor ?? widget.borderColor ?? AppColors.white);
    } else {
      return WidgetStateProperty.all<Color>(AppColors.primaryColor);
    }
  }

  void _onPressed() {
    if (!_isAnimating) {
      /// 1st step to 90
      /// set _isAnimating to true
      setState(() {
        if (mounted) {
          _animationController?.forward();
        }
        _animationState = AppButtonAnimationState.stateShrink;
        _isAnimating = true;
      });

      /// 2nd step to 110
      Future<void>.delayed(kDuration200, () {
        if (mounted) {
          setState(() => _animationState = AppButtonAnimationState.stateGrow);
        }
      });

      /// 3rd step back to 100
      /// set _isAnimating back to false
      Future<void>.delayed(kDuration400, () {
        if (mounted) {
          setState(() => _animationState = AppButtonAnimationState.stateNormal);
          _animationController?.reset();
          _isAnimating = false;
        }
      });

      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    } else {
      _isAnimating = false;
    }
  }

  double buttonAnimationScale(AppButtonAnimationState animationState) {
    switch (animationState) {
      case AppButtonAnimationState.stateShrink:
        return 0.94;
      case AppButtonAnimationState.stateGrow:
        return 1.04;
      default:
        return 1.0;
    }
  }
}
