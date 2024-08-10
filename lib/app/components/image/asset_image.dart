import 'package:flutter/cupertino.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage({
    super.key,
    this.borderRadius,
    required this.url,
    this.fit,
    this.width,
    this.height,
    this.scale = 1.0,
    this.color,
    this.alignment,
    this.roundShape = false,
  });

  final BorderRadius? borderRadius;
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? scale;
  final Color? color;
  final Alignment? alignment;
  final bool roundShape;

  @override
  Widget build(BuildContext context) {
    if (url == '') {
      return Container();
    }

    final Widget imageView = Image.asset(
      url,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
      scale: scale,
      alignment: alignment ?? Alignment.center,
      errorBuilder: (_, __, StackTrace? stackTrace) {
        return _errorImageView;
      },
    );

    if (roundShape) {
      return ClipOval(
        child: imageView,
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: imageView,
      );
    }
  }

  Widget get _errorImageView => Image.asset(
        'assets/images/default/default_no_image.png',
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        color: color,
        alignment: alignment ?? Alignment.center,
      );
}
