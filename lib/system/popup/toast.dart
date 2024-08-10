// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app/components/popup/toast.dart';
import '../global_style.dart';
import '../variables/durations.dart';

class AppToast {
  static void sInformation({
    required BuildContext context,
    String? text,
    Duration duration = kDuration3s,
  }) {
    sBasic(
      text: text,
      context: context,
      duration: duration,
    );
  }

  static void sWarning({
    required BuildContext context,
    String? text,
    Duration duration = kDuration3s,
  }) {
    sBasic(
      text: text,
      context: context,
      duration: duration,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.amber,
    );
  }

  static void sError({
    required BuildContext context,
    String? text,
    Duration duration = kDuration3s,
    ToastGravity? gravity,
  }) {
    sBasic(
      text: text ?? '',
      context: context,
      duration: duration,
      icon: Icons.error_outline_rounded,
      iconColor: Colors.redAccent,
      gravity: gravity,
    );
  }

  static void sSuccess({
    required BuildContext context,
    String? text,
    Duration duration = kDuration3s,
  }) {
    sBasic(
      text: text,
      context: context,
      duration: duration,
      icon: Icons.check,
      iconColor: Colors.green,
    );
  }

  static void sBasic({
    required BuildContext context,
    String? text,
    IconData? icon,
    String? image,
    Duration duration = kDuration5s,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    ToastGravity? gravity,
  }) {
    final FToast fToast = FToast();

    fToast.init(context);
    fToast.removeCustomToast();
    fToast.showToast(
      child: AppToastView(
        context: context,
        text: text,
        icon: icon,
        image: image,
        backgroundColor: backgroundColor,
        textColor: textColor,
        iconColor: iconColor,
      ),
      gravity: gravity ?? ToastGravity.BOTTOM,
      toastDuration: duration,
      positionedToastBuilder: (BuildContext context, Widget child) {
        return Positioned(
          bottom: 10,
          left: AppSpacer.instance.sm,
          right: AppSpacer.instance.sm,
          child: child,
        );
      },
    );
  }
}
