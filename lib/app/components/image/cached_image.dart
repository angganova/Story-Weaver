// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import '../../../system/global_extension.dart';
import '../../../system/style/colors.dart';
import '../../../system/style/media_query/media_query.dart';
import '../../../system/variables/var_style.dart';
import 'asset_image.dart';

class AppCachedImage extends StatefulWidget {
  const AppCachedImage(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.fit,
      this.color,
      this.blendMode,
      this.errorWidget,
      this.alignment = Alignment.center,
      this.showLoading = true,
      this.roundShape = false,
      this.showErrorImage = true,
      this.borderRadius,
      this.bgColor = AppColors.transparent,
      this.onError});
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? blendMode;
  final Alignment alignment;
  final Widget? errorWidget;
  final bool showLoading;
  final bool roundShape;
  final bool showErrorImage;
  final BorderRadius? borderRadius;
  final Color bgColor;
  final Function(dynamic)? onError;

  static Widget profilePicture({
    required String url,
    double? width,
    double? height,
    bool withBorder = false,
  }) {
    final Widget child = AppCachedImage(
      url: url,
      width: width ?? AppQuery.instance.responsiveWidth(10),
      height: height ?? AppQuery.instance.responsiveWidth(10),
      fit: BoxFit.cover,
      roundShape: true,
      errorWidget: AppAssetImage(
        url: 'assets/images/default/no_user_picture.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
        roundShape: true,
        color: AppColors.black,
      ),
    );

    if (withBorder) {
      return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        padding: const EdgeInsets.all(3),
        child: child,
      );
    } else {
      return child;
    }
  }

  static Widget songPicture({
    required String url,
    double? width,
    double? height,
    bool withBorder = false,
    BoxFit? fit,
    BorderRadius? borderRadius,
    bool roundShape = false,
  }) {
    final Widget child = AppCachedImage(
      url: url,
      width: width ?? AppQuery.instance.responsiveWidth(10),
      height: height ?? AppQuery.instance.responsiveWidth(10),
      fit: fit ?? BoxFit.cover,
      roundShape: roundShape,
      borderRadius: borderRadius ?? kBorderRadiusAll24,
      errorWidget: AppAssetImage(
        url: 'assets/images/default/no_song.png',
        width: width,
        height: height,
        fit: BoxFit.cover,
        roundShape: roundShape,
        color: AppColors.black,
        borderRadius: borderRadius ?? kBorderRadiusAll24,
      ),
    );

    if (withBorder) {
      return Container(
        decoration: BoxDecoration(
          shape: roundShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: roundShape ? null : borderRadius ?? kBorderRadiusAll24,
          color: AppColors.primaryColor,
        ),
        padding: const EdgeInsets.all(2),
        child: child,
      );
    } else {
      return child;
    }
  }

  @override
  _AppCachedImageState createState() => _AppCachedImageState();
}

class _AppCachedImageState extends State<AppCachedImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.roundShape) {
      return ClipOval(
        child: _cachedImageView,
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: _cachedImageView,
      );
    }
  }

  Widget get _cachedImageView {
    if (widget.url.isNullOrEmpty) {
      return _defaultErrorWidget;
    }

    return CachedNetworkImage(
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      fit: widget.fit ?? BoxFit.cover,
      colorBlendMode: widget.blendMode,
      alignment: widget.alignment,
      errorWidget: (BuildContext context, String url, dynamic error) {
        if (widget.showErrorImage) {
          return widget.errorWidget ?? _defaultErrorWidget;
        } else {
          return Container();
        }
      },
      placeholder: (BuildContext context, String url) => widget.showLoading
          ? Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: widget.borderRadius,
                color: AppColors.grayDark,
              ),
            )
          : Container(),
    );
  }

  Widget get _defaultErrorWidget {
    if (widget.roundShape) {
      return ClipOval(
        child: Container(
          color: widget.bgColor,
          width: widget.width,
          height: widget.height,
          child: widget.errorWidget ?? _errorImageView,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(0),
        child: Container(
          color: widget.bgColor,
          width: widget.width,
          height: widget.height,
          child: widget.errorWidget ?? _errorImageView,
        ),
      );
    }
  }

  Widget get _errorImageView => AppAssetImage(
        url: 'assets/images/default/default_no_image.png',
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      );
}
