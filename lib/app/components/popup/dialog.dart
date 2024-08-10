import 'package:flutter/material.dart';

import '../../../system/global_style.dart';
import '../../../system/variables/var_style.dart';
import '../button/elevated_button.dart';
import '../text/basic_text.dart';

class AppDialogView extends StatefulWidget {
  const AppDialogView({
    super.key,
    this.title,
    this.detailWidget,
    this.detail,
    this.topWidget,
    this.confirmText = 'Ok',
    this.confirmCallback,
    this.cancelText = 'Batal',
    this.cancelCallback,
    this.confirmButtonColor,
    this.confirmButtonTextColor,
    this.isConfirmButtonOutlined = false,
    this.isCancelButtonOutlined = true,
  });

  final String? title;
  final Widget? detailWidget;
  final String? detail;
  final Widget? topWidget;

  final String? confirmText;
  final VoidCallback? confirmCallback;
  final Color? confirmButtonColor;
  final Color? confirmButtonTextColor;
  final bool isConfirmButtonOutlined;

  final String? cancelText;
  final VoidCallback? cancelCallback;
  final bool isCancelButtonOutlined;

  @override
  State<AppDialogView> createState() => _AppDialogViewState();
}

class _AppDialogViewState extends State<AppDialogView> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 4,
      insetPadding: AppSpacer.instance.edgeInsets.zero,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: kBorderRadiusAll10,
      ),
      child: Padding(
        padding: AppSpacer.instance.edgeInsets.all.standard,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.topWidget != null) widget.topWidget!,
            if (widget.topWidget != null) AppSpacer.instance.vHsm,
            if (widget.title != null)
              AppText.formInput(
                widget.title ?? '',
                align: TextAlign.center,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            if (widget.title != null) AppSpacer.instance.vHsm,
            if (widget.detailWidget != null)
              widget.detailWidget!
            else if (widget.detail != null)
              AppText(
                widget.detail ?? '',
                color: AppColors.textColorGray,
                textStyle: AppTextStyle.instance.paragraph,
                maxLines: 20,
                align: TextAlign.center,
              ),
            if (widget.detail != null) AppSpacer.instance.vHstandard,
            _actionView
          ],
        ),
      ),
    );
  }

  Widget get _actionView {
    return Row(
      children: <Widget>[
        if (widget.cancelCallback != null) Expanded(child: _cancelButtonView),
        if (widget.cancelCallback != null) AppSpacer.instance.vWsm,
        Expanded(child: _confirmButtonView),
      ],
    );
  }

  Widget get _confirmButtonView {
    if (widget.isConfirmButtonOutlined) {
      return AppElevatedButton.outlined(
        text: widget.confirmText ?? '',
        color: widget.confirmButtonColor ?? AppColors.primaryColor,
        onPressed: widget.confirmCallback ?? () => Navigator.of(context).pop(),
      );
    } else {
      return AppElevatedButton(
        text: widget.confirmText ?? '',
        backgroundColor: widget.confirmButtonColor ?? AppColors.primaryColor,
        borderColor: widget.confirmButtonColor ?? AppColors.primaryColor,
        onPressed: widget.confirmCallback ?? () => Navigator.of(context).pop(),
        textColor: widget.confirmButtonTextColor,
      );
    }
  }

  Widget get _cancelButtonView {
    if (widget.isCancelButtonOutlined) {
      return AppElevatedButton.outlined(
        text: widget.cancelText ?? '',
        onPressed: widget.cancelCallback ?? () => Navigator.of(context).pop(),
        textStyle: AppTextStyle.instance.b1.copyWith(
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return AppElevatedButton(
        text: widget.cancelText ?? '',
        backgroundColor: AppColors.primaryColor,
        borderColor: AppColors.primaryColor,
        onPressed: widget.cancelCallback ?? () => Navigator.of(context).pop(),
        textStyle: AppTextStyle.instance.b1.copyWith(
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }
}
