import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:story_weaver/system/service/file_service.dart';

import '../popup/dialog.dart';

class ShareService {
  Future<void> shareScreenshot({
    required BuildContext context,
    required ScreenshotController controller,
  }) async {
    AppDialog.instance.sLoading(context);
    try {
      final Uint8List? image = await controller.capture();
      final XFile? xFile = await FileService().createXFileImage(image);
      if (xFile != null) {
        Share.shareXFiles(<XFile>[xFile]);
      } else if (context.mounted) {
        AppDialog.instance.sError(
          context: context,
          detail: 'Share story failed, please try again',
        );
      }
      AppDialog.instance.hLoading();
    } catch (e) {
      AppDialog.instance.hLoading();
      if (context.mounted) {
        AppDialog.instance.sError(
          context: context,
          detail: 'Share story failed, please try again',
        );
      }
    }
  }
}
