// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../system/extension/num_extension.dart';
import '../../../system/global_style.dart';
import '../button/icon_button.dart';
import '../text/basic_text.dart';

class AppListTile extends StatefulWidget {
  const AppListTile({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.withDivider = false,
    this.padding,
    this.dividerPadding,
    this.withSplash = true,
    this.withPaddingSubtitle = true,
    this.borderRadius,
    this.rowAlignment,
    this.dividerColor = AppColors.borderBlack,
    this.dividerHeight = 1,
    this.onLongPress,
    this.badge,
  });

  factory AppListTile.imageLabel({
    required Widget child,
    required String label,
    VoidCallback? onTap,
  }) {
    return AppListTile(
        onTap: onTap,
        title: Center(child: child),
        subtitle: Center(
          child: AppText.label(label, align: TextAlign.center),
        ));
  }

  factory AppListTile.widgetTopLabel({
    required String label,
    required Widget child,
    Color? labelColor,
    Alignment? alignment = Alignment.centerLeft,
    TextAlign textAlign = TextAlign.center,
    bool withPaddingSubtitle = true,
    EdgeInsets? contentPadding,
  }) {
    final Widget labelView = AppText.label(
      label,
      align: textAlign,
      color: labelColor ?? AppColors.primaryColor,
    );

    return AppListTile(
      title: Container(alignment: alignment, child: labelView),
      subtitle: child,
      withPaddingSubtitle: withPaddingSubtitle,
      padding: contentPadding,
    );
  }

  factory AppListTile.buttonNavigation({
    required String title,
    Widget? leadingWidget,
    Widget? trailingWidget,
    VoidCallback? onTap,
    bool withDivider = false,
    double dividerHeight = 1,
    EdgeInsets? padding,
    Color? color,
    Widget? badge,
    TextStyle? textStyle,
  }) {
    return AppListTile(
      padding: padding ?? AppSpacer.instance.edgeInsets.y.sm,
      title: AppText(
        title,
        color: color,
        textStyle: textStyle ??
            AppTextStyle.instance.paragraph.copyWith(
              fontWeight: FontWeight.w400,
            ),
      ),
      leading: leadingWidget,
      trailing: trailingWidget ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: AppQuery.instance.responsiveWidth(4),
            color: AppColors.black,
          ),
      onTap: onTap,
      withDivider: withDivider,
      dividerHeight: dividerHeight,
      dividerColor: Colors.grey[300]!,
      dividerPadding: AppSpacer.instance.edgeInsets.all.none,
      badge: badge,
    );
  }

  factory AppListTile.titleSubtitle({
    required String title,
    required String subtitle,
    EdgeInsets? padding,
    Color? titleColor,
    Color? subtitleColor,
    VoidCallback? onTap,
    bool? withDivider,
  }) {
    return AppListTile(
      padding: padding,
      title: AppText.sectionHeader(
        title,
        color: titleColor ?? AppColors.textPrimary,
      ),
      subtitle: AppText.paragraph(
        subtitle,
        color: subtitleColor ?? AppColors.textBlack,
        maxLines: 5,
      ),
      onTap: onTap,
      withDivider: withDivider ?? false,
    );
  }

  factory AppListTile.titleSubtitleTrailing({
    required String title,
    required String subtitle,
    required Widget trailing,
    EdgeInsets? padding,
    Color? titleColor,
    Color? subtitleColor,
    VoidCallback? onTap,
    bool? withDivider,
  }) {
    return AppListTile(
      padding: padding,
      title: AppText.sectionHeader(
        title,
        color: titleColor ?? AppColors.textPrimary,
      ),
      subtitle: AppText.paragraph(
        subtitle,
        color: subtitleColor ?? AppColors.textBlack,
        maxLines: 5,
      ),
      onTap: onTap,
      withDivider: withDivider ?? false,
      trailing: trailing,
    );
  }

  factory AppListTile.titleLeading(
      {required String title,
      required Widget leading,
      EdgeInsets? padding,
      VoidCallback? onTap,
      bool withDivider = false,
      Color? dividerColor}) {
    return AppListTile(
      title: AppText.paragraph(title),
      leading: leading,
      padding: padding,
      onTap: onTap,
      withDivider: withDivider,
      dividerColor: dividerColor,
    );
  }

  factory AppListTile.sectionHeadline({
    required String title,
    Widget? leading,
    Widget? trailing,
    EdgeInsets? padding,
  }) {
    return AppListTile(
      leading: leading,
      title: AppText.headline(
        title,
        color: AppColors.textColorBlack,
        fontWeight: FontWeight.w600,
      ),
      trailing: trailing,
      padding: padding,
      rowAlignment: CrossAxisAlignment.center,
    );
  }

  factory AppListTile.titleTrailing(
      {required String title,
      required Widget trailing,
      EdgeInsets? padding,
      VoidCallback? onTap,
      bool withDivider = false,
      Color? dividerColor}) {
    return AppListTile(
      title: AppText.paragraph(title),
      trailing: trailing,
      padding: padding,
      onTap: onTap,
      withDivider: withDivider,
      dividerColor: dividerColor,
    );
  }

  factory AppListTile.header({
    required String title,
    Widget? trailing,
    VoidCallback? onClose,
  }) {
    return AppListTile(
      title: AppText.h1(title),
      trailing: trailing ??
          AppIconButton.transparent(
            onTap: onClose,
            icon: Icons.close,
          ),
    );
  }

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final bool withSplash;
  final bool withPaddingSubtitle;

  final bool withDivider;
  final double dividerHeight;
  final Color? dividerColor;
  final EdgeInsets? dividerPadding;

  final BorderRadius? borderRadius;

  final CrossAxisAlignment? rowAlignment;

  final Widget? badge;

  @override
  _AppListTileState createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.withSplash) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: AppColors.transparent,
            child: InkWell(
              borderRadius: widget.borderRadius,
              onTap: widget.onTap,
              onLongPress: widget.onLongPress,
              child: _mainView,
            ),
          ),
          if (widget.withDivider)
            Container(
              margin:
                  widget.dividerPadding ?? AppSpacer.instance.edgeInsets.x.sm,
              width: AppQuery.instance.width,
              color: widget.dividerColor ?? AppColors.borderBlack,
              height: widget.dividerHeight,
            ),
        ],
      );
    } else {
      return GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: _mainView,
      );
    }
  }

  Widget get _mainView => SizedBox(
        width: AppQuery.instance.width,
        child: Padding(
          padding: widget.padding ?? AppSpacer.instance.edgeInsets.all.sm,
          child: Row(
            crossAxisAlignment:
                widget.rowAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) AppSpacer.instance.vWsm,
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.title ?? Container(),
                          if (widget.subtitle != null &&
                              widget.withPaddingSubtitle)
                            AppSpacer.instance.vHxs,
                          if (widget.subtitle != null) widget.subtitle!,
                        ],
                      ),
                    ),
                    if (widget.badge != null) AppSpacer.instance.vWxs,
                    if (widget.badge != null) widget.badge!,
                  ],
                ),
              ),
              if (widget.trailing != null) AppSpacer.instance.vWsm,
              if (widget.trailing != null) widget.trailing!
            ],
          ),
        ),
      );
}
