import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../system/global_style.dart';
import '../button/elevated_button.dart';
import '../image/asset_image.dart';
import '../image/cached_image.dart';
import '../text/basic_text.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    this.okCallback,
    this.cancelCallback,
    this.imageUrl,
    this.imageAsset,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.okText,
    this.cancelText,
    this.autoDismiss = false,
    this.svgAsset,
  });

  final String? imageUrl;
  final String? imageAsset;
  final String? svgAsset;
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String? okText;
  final VoidCallback? okCallback;

  final String? cancelText;
  final VoidCallback? cancelCallback;

  final bool autoDismiss;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppQuery.instance.width,
        height: AppQuery.instance.height,
        padding: AppSpacer.instance.edgeInsets.all.sm,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            GestureDetector(
              onTap: _onTapImage,
              child: _imageView,
            ),
            AppSpacer.instance.vHmd,
            AppText.h2(title ?? ''),
            AppSpacer.instance.vHstandard,
            subtitleWidget ??
                AppText.paragraph(
                  subtitle ?? '',
                  align: TextAlign.center,
                ),
            AppSpacer.instance.vHsm,
            const Spacer(),
            if (okCallback != null) AppSpacer.instance.vHsm,
            if (okCallback != null)
              AppElevatedButton.primary(
                text: okText ?? 'Retry',
                onPressed: () {
                  if (autoDismiss) {
                    Navigator.of(context).pop();
                  }
                  if (okCallback != null) {
                    okCallback?.call();
                  }
                },
              ),
            if (cancelCallback != null) AppSpacer.instance.vHsm,
            if (cancelCallback != null || okCallback == null)
              AppElevatedButton(
                text: cancelText ?? (okCallback == null ? 'Ok' : 'Cancel'),
                onPressed: () {
                  if (autoDismiss) {
                    Navigator.of(context).pop();
                  }
                  if (cancelCallback != null) {
                    cancelCallback?.call();
                  }
                },
              ),
            AppSpacer.instance.vHsm,
          ],
        ),
      ),
    );
  }

  Widget get _imageView {
    final double assetImageWidth = AppQuery.instance.screenWidthFull;

    if (imageAsset != null) {
      return AppAssetImage(
        url: imageAsset ?? '',
        width: assetImageWidth,
        height: assetImageWidth,
        fit: BoxFit.contain,
      );
    } else if (imageUrl != null) {
      return AppCachedImage(
        url: imageUrl ?? '',
        width: assetImageWidth,
        height: assetImageWidth,
        fit: BoxFit.contain,
      );
    } else {
      return Container();
    }
  }

  void _onTapImage() {
    if (kDebugMode) {
      // AppRouter.instance.push(const LocalBugTrackerView());
    }
  }
}
