import 'package:flutter/material.dart';
import '../../../system/service/navigator.dart';
import '../../../system/style/colors.dart';
import '../button/icon_button.dart';
import '../text/basic_text.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHeader({
    this.backgroundColor,
    this.leading,
    this.titleSpacing,
    this.title,
    this.actions,
    super.key,
    this.elevation = 0,
  });

  factory AppBarHeader.basic({
    VoidCallback? ctaBack,
    String? title,
    bool disableBackButton = false,
  }) {
    return AppBarHeader(
      backgroundColor: AppColors.white,
      leading: !disableBackButton
          ? AppIconButton.transparent(
              icon: Icons.arrow_back,
              iconColor: AppColors.textColorBlack,
              onTap: ctaBack ?? () => AppNavigator.instance.pop(),
            )
          : null,
      title: AppText.h2(
        title ?? '',
        isBold: true,
      ),
      elevation: 0,
    );
  }

  factory AppBarHeader.transparent({
    required BuildContext context,
    VoidCallback? ctaBack,
    String? title,
    Color? textColor,
  }) {
    return AppBarHeader(
      backgroundColor: AppColors.transparent,
      leading: AppIconButton.transparent(
        icon: Icons.arrow_back,
        iconColor: textColor ?? AppColors.textColorBlack,
        onTap: ctaBack ?? () => AppNavigator.instance.pop(context),
      ),
      title: AppText.h2(
        title ?? '',
        isBold: true,
        color: textColor ?? AppColors.textColorBlack,
      ),
      elevation: 0,
    );
  }

  factory AppBarHeader.defaultHeader({
    required String title,
    Function? onTapBack,
    List<Widget>? actions,
    bool showBackButton = true,
    bool isLightColor = true,
    bool arrowIcon = true,
  }) {
    return AppBarHeader(
      backgroundColor: isLightColor ? AppColors.white : AppColors.primaryColor,
      leading: !showBackButton
          ? null
          : InkWell(
              child: Icon(
                arrowIcon ? Icons.arrow_back : Icons.close,
                size: 24,
                color:
                    isLightColor ? AppColors.textColorBlack : AppColors.white,
              ),
              onTap: () {
                if (onTapBack != null) {
                  onTapBack.call();
                } else {
                  AppNavigator.instance.pop();
                }
              },
            ),
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.only(left: 16),
        child: AppText.h2(
          title,
          color: isLightColor ? AppColors.textColorBlack : AppColors.white,
          fontWeight: FontWeight.w600,
          maxLines: 1,
        ),
      ),
      actions: actions,
    );
  }

  final Color? backgroundColor;
  final Widget? leading;
  final double? titleSpacing;
  final Widget? title;
  final List<Widget>? actions;
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        leading: leading,
        titleSpacing: titleSpacing,
        title: title,
        actions: actions,
        elevation: elevation,
        automaticallyImplyLeading: leading != null);
  }
}
