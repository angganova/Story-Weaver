import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../system/global_style.dart';
import '../../../system/global_variable.dart';
import '../button/elevated_button.dart';
import '../image/asset_image.dart';
import '../image/cached_image.dart';
import '../text/basic_text.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    super.key,
    this.okCallback,
    this.imageUrl,
    this.imageAsset,
    this.imageSvg,
    this.title,
    this.subtitle,
    this.subtitleWidget,
    this.okText,
    this.imageWidth,
    this.width,
    this.height,
    this.autoPopWhenOk = true,
  });

  factory AppEmptyView.noTransaction({double? imageWidth}) {
    return AppEmptyView(
      imageSvg: 'assets/images/svg/no_transaction.svg',
      title: 'Belum ada transaksi baru',
      imageWidth: imageWidth ?? AppQuery.instance.screenWidthHalf,
    );
  }

  factory AppEmptyView.emptySearch(String searchText, {double? imageWidth}) {
    return AppEmptyView(
      imageSvg: 'assets/images/svg/no_transaction.svg',
      title: 'Pencarian untuk $searchText tidak ditemukan',
      imageWidth: imageWidth ?? AppQuery.instance.screenWidthHalf,
    );
  }

  factory AppEmptyView.noTransactionSummary({VoidCallback? retryCB}) {
    return AppEmptyView(
      imageSvg: 'assets/images/svg/no_transaction.svg',
      title: 'Belum ada transaksi',
      height: AppQuery.instance.responsiveHeight(50),
      imageWidth: AppQuery.instance.responsiveWidth(40),
      okCallback: retryCB,
      autoPopWhenOk: false,
    );
  }

  factory AppEmptyView.errorTransactionSummary({VoidCallback? retryCB}) {
    return AppEmptyView(
      imageSvg: 'assets/images/svg/no_transaction.svg',
      title: 'Terjadi kesalahaan saat mengambil data, silahkan coba lagi',
      height: AppQuery.instance.responsiveHeight(50),
      imageWidth: AppQuery.instance.responsiveWidth(40),
      okCallback: retryCB,
      autoPopWhenOk: false,
    );
  }

  final double? width;
  final double? height;
  final String? imageUrl;
  final String? imageAsset;
  final String? imageSvg;
  final double? imageWidth;
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String? okText;
  final VoidCallback? okCallback;
  final bool autoPopWhenOk;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppQuery.instance.width,
      height: height ?? AppQuery.instance.height,
      padding: AppSpacer.instance.edgeInsets.all.sm,
      alignment: Alignment.center,
      child: SizedBox(
        width: AppQuery.instance.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            GestureDetector(
              onTap: _onTapImage,
              child: _imageView,
            ),
            AppSpacer.instance.vHmd,
            AppText.sectionHeader(
              title ?? '',
              color: AppColors.greyB,
              align: TextAlign.center,
            ),
            AppSpacer.instance.vHstandard,
            subtitleWidget ?? AppText.paragraph(subtitle ?? ''),
            AppSpacer.instance.vHsm,
            const Spacer(),
            if (okCallback != null) AppSpacer.instance.vHsm,
            if (okCallback != null)
              AppElevatedButton.primary(
                text: okText ?? 'Coba Lagi',
                onPressed: () {
                  if (autoPopWhenOk) {
                    Navigator.pop(context);
                  }
                  if (okCallback != null) {
                    Future<void>.delayed(kDuration100, () => okCallback!());
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
    final double assetImageWidth =
        imageWidth ?? AppQuery.instance.screenWidthFull;

    if (imageAsset != null) {
      return AppAssetImage(
        url: imageAsset!,
        width: assetImageWidth,
        fit: BoxFit.contain,
      );
    } else if (imageUrl != null) {
      return AppCachedImage(
        url: imageUrl!,
        width: assetImageWidth,
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
