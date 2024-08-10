import 'package:flutter/material.dart';

import '../../../system/global_style.dart';
import '../../../system/variables/var_style.dart';
import '../text/basic_text.dart';

class AppToastView extends StatelessWidget {
  const AppToastView({
    super.key,
    required this.context,
    this.text,
    this.icon,
    this.image,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.useShadow = true,
  });

  final BuildContext context;
  final String? text;
  final bool useShadow;

  final IconData? icon;
  final String? image;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: AppSpacer.instance.edgeInsets.all.sm,
        width: AppQuery.instance.width,
        decoration: BoxDecoration(
          borderRadius: kBorderRadiusAll8,
          color: backgroundColor ?? Colors.white,
          boxShadow: useShadow
              ? const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: -1,
                    blurRadius: 2,
                    // offset: Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (image != null)
              Image.asset(image!)
            else if (icon != null)
              Icon(
                icon,
                color: iconColor ?? textColor,
              ),
            AppSpacer.instance.vWxs,
            Expanded(
              child: AppText.paragraph(
                text ?? '',
                align: TextAlign.center,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
