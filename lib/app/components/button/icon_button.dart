import 'package:flutter/material.dart';

import '../../../system/global_style.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.onTap,
    this.icon,
    this.iconAsset,
    this.iconColor,
    this.bgColor,
    this.borderColor,
    this.iconSize,
  });

  factory AppIconButton.primary(
          {VoidCallback? onTap, IconData? icon, double? iconSize}) =>
      AppIconButton(
        onTap: onTap,
        icon: icon,
        iconColor: AppColors.white,
        iconSize: iconSize,
        bgColor: AppColors.primaryColor,
        borderColor: AppColors.primaryColor,
      );

  factory AppIconButton.transparent({
    VoidCallback? onTap,
    IconData? icon,
    Color? iconColor,
    double? iconSize,
  }) =>
      AppIconButton(
        onTap: onTap,
        icon: icon,
        iconColor: iconColor ?? AppColors.iconBlack,
        iconSize: iconSize,
        bgColor: AppColors.transparent,
        borderColor: AppColors.transparent,
      );

  final VoidCallback? onTap;
  final IconData? icon;
  final String? iconAsset;
  final double? iconSize;
  final Color? iconColor;

  final Color? bgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            onTap != null ? bgColor ?? AppColors.white : AppColors.disableGrey,
        border: Border.fromBorderSide(
          BorderSide(
            color: onTap != null
                ? borderColor ?? AppColors.white
                : AppColors.disableGrey,
            width: 2,
          ),
        ),
      ),
      child: IconButton(
        onPressed: onTap,
        color: bgColor,
        disabledColor: AppColors.disableGrey,
        icon: Icon(
          icon,
          color: iconColor ?? AppColors.textBlack,
          size: iconSize,
        ),
      ),
    );
  }
}
