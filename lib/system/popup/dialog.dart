import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/components/global/error_view.dart';
import '../../app/components/loading/basic_loading.dart';
import '../../app/components/popup/dialog.dart';
import '../../app/screen/global/input_text_screen.dart';
import '../global_style.dart';

class AppDialog {
  AppDialog._();

  static final AppDialog instance = AppDialog._();

  BuildContext? loadingDialogContext;
  BuildContext? currentDialogContext;

  /// Progress Dialog
  /// Show Progress Dialog
  Future<void> sLoading(BuildContext context) async {
    if (loadingDialogContext != null) {
      hLoading();
    }

    loadingDialogContext = context;
    await showBasicDialog(
      context: context,
      view: AppBasicLoading.withBackground(),
      barrierDismissible: false,
      disableBackButton: true,
      margin: AppSpacer.instance.edgeInsets.x.md,
    );
  }

  /// Hide Progress Dialog
  void hLoading() {
    if (loadingDialogContext == null) {
      return;
    }

    try {
      Navigator.of(loadingDialogContext!).pop();
      loadingDialogContext = null;
    } catch (_) {}
  }

  /// Dialog start

  Future<void> sInformation({
    required BuildContext context,
    String? title,
    String? detail,
    String? confirmText = 'OK',
    VoidCallback? confirmCallback,
    bool barrierDismissible = true,
    bool disableBackButton = false,
  }) async {
    final Widget view = AppDialogView(
      title: title,
      detail: detail,
      confirmText: confirmText,
      confirmCallback: confirmCallback ?? () => dismissCurrentPopUp(),
    );

    await showBasicDialog(
      context: context,
      view: view,
      barrierDismissible: barrierDismissible,
      disableBackButton: disableBackButton,
    );
  }

  Future<void> sConfirmation({
    required BuildContext context,
    String? title,
    Widget? detailWidget,
    String? detail,
    String? confirmText,
    VoidCallback? confirmCallback,
    String? cancelText,
    VoidCallback? cancelCallback,
    TextAlign descTextAlign = TextAlign.center,
    Color? confirmButtonColor,
  }) async {
    final Widget view = AppDialogView(
      title: title,
      detailWidget: detailWidget,
      detail: detail,
      confirmText: confirmText ?? 'OK',
      confirmCallback: confirmCallback ?? () => dismissCurrentPopUp(),
      cancelText: cancelText ?? 'Cancel',
      cancelCallback: cancelCallback ?? () => dismissCurrentPopUp(),
      confirmButtonColor: confirmButtonColor,
    );

    await showBasicDialog(
      context: context,
      view: view,
      margin: AppSpacer.instance.edgeInsets.x.sm,
    );
  }

  Future<void> sSuccess({
    required BuildContext context,
    String? title,
    String? detail,
    String? confirmText = 'Ok',
    VoidCallback? confirmCallback,
  }) async {
    await sInformation(
      barrierDismissible: false,
      disableBackButton: true,
      context: context,
      title: title,
      detail: detail,
      confirmText: confirmText,
      confirmCallback: confirmCallback,
    );
  }

  Future<void> sWarning({
    required BuildContext context,
    String? title,
    String? detail,
    String? confirmText,
    VoidCallback? confirmCallback,
  }) async {
    final Widget view = AppDialogView(
      title: title,
      detail: detail,
      confirmText: confirmText ?? 'OK',
      confirmCallback: confirmCallback ?? () => dismissCurrentPopUp(),
    );

    await showBasicDialog(
      context: context,
      view: view,
    );
  }

  Future<void> sError({
    required BuildContext context,
    String? title,
    String? detail,
    String? confirmText,
    VoidCallback? confirmCallback,
    bool confirmOutlined = false,
    String? cancelText,
    VoidCallback? cancelCallback,
    String? image,
    bool barrierDismissible = true,
    bool disableBackButton = false,
  }) async {
    final Widget view = AppDialogView(
      title: title,
      detail: detail,
      confirmText: confirmText ?? 'OK',
      confirmCallback: confirmCallback ?? () => dismissCurrentPopUp(),
      isConfirmButtonOutlined: confirmOutlined,
      cancelText: cancelText,
      cancelCallback: cancelCallback,
      confirmButtonColor: AppColors.errorColor,
    );

    await showBasicDialog(
      context: context,
      view: view,
      barrierDismissible: barrierDismissible,
      disableBackButton: disableBackButton,
    );
  }

  Future<void> sApiError({
    required BuildContext context,
    String? message,
    VoidCallback? retryCallback,
    VoidCallback? cancelCallback,
  }) async {
    dismissCurrentPopUp();

    if (retryCallback != null) {
      await sConfirmation(
        context: context,
        title: 'Oops...',
        detail: message ?? '',
        confirmText: 'Coba Lagi',
        confirmCallback: () {
          dismissCurrentPopUp();
          retryCallback();
        },
        cancelText: 'Batal',
        cancelCallback: () {
          dismissCurrentPopUp();
          if (cancelCallback != null) {
            cancelCallback();
          }
        },
      );
    } else {
      sError(
        context: context,
        title: 'Oops...',
        detail: message ?? '',
        confirmText: 'Ok',
        confirmCallback: cancelCallback,
      );
    }
  }

  Future<void> sNoInternet({
    required BuildContext context,
    VoidCallback? retryCallback,
    VoidCallback? cancelCallback,
  }) async {
    await sConfirmation(
      context: context,
      title: 'Koneksi Internet Error',
      detail: 'Koneksi internet Anda tidak terhubung / tidak bekerja',
      confirmText: 'Coba Lagi',
      confirmCallback: () {
        dismissCurrentPopUp();
        if (retryCallback != null) {
          retryCallback();
        }
      },
      cancelText: 'Batal',
      cancelCallback: () {
        dismissCurrentPopUp();
        if (cancelCallback != null) {
          cancelCallback();
        }
      },
    );
  }

  Future<void> sServerMaintenanceFullScreen({
    required BuildContext context,
    VoidCallback? retryCallback,
    VoidCallback? cancelCallback,
  }) async {
    dismissCurrentPopUp();

    await showDialog<void>(
        useSafeArea: false,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          currentDialogContext = buildContext;
          return PopScope(
            canPop: false,
            child: AppErrorView(
              title: 'Oops...',
              subtitle: 'Sayangnya ada sesuatu yang salah. Silakan coba lagi.',
              imageAsset: 'assets/images/default/server_error.png',
              okCallback: retryCallback,
              cancelCallback: cancelCallback,
              autoDismiss: true,
            ),
          );
        });
    resetPopUp();
  }

  Future<dynamic> sFullScreenDialog({
    required BuildContext context,
    required Widget view,
    bool disableBackButton = false,
  }) async {
    dismissCurrentPopUp();

    return await showDialog<void>(
        useSafeArea: false,
        context: context,
        barrierDismissible: true,
        builder: (BuildContext? context) {
          currentDialogContext = context;
          return PopScope(
            canPop: !disableBackButton,
            child: view,
          );
        });
  }

  Future<String?> sInputText(
    BuildContext context, {
    num initialValue = 0,
    num? minValue,
    num? maxValue,
  }) async {
    dismissCurrentPopUp();
    dynamic value = await AppDialog.instance.sFullScreenDialog(
      context: context,
      view: const InputTextScreen(),
    );
    if (value != null) {
      return value.toString();
    }
    return value;
  }

  Future<dynamic> showBasicDialog({
    required BuildContext context,
    Widget? view,
    bool barrierDismissible = true,
    bool disableBackButton = false,
    EdgeInsets? margin,
  }) async {
    return await showDialog<dynamic>(
      context: context,
      useSafeArea: true,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext? context) {
        currentDialogContext = context;
        return PopScope(
          canPop: !disableBackButton,
          child: Dialog(
            backgroundColor: AppColors.transparent,
            insetPadding: margin ?? AppSpacer.instance.edgeInsets.all.sm,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: view,
          ),
        );
      },
    );
  }

  Future<dynamic> showBackDropDialog({
    required BuildContext context,
    Widget? view,
    bool barrierDismissible = false,
    bool disableBackButton = false,
  }) async {
    dismissCurrentPopUp();

    return await showDialog<dynamic>(
        context: context,
        useSafeArea: false,
        barrierDismissible: barrierDismissible,
        barrierColor: AppColors.transparent,
        builder: (BuildContext? context) {
          currentDialogContext = context;

          final Widget content = SizedBox(
            width: AppQuery.instance.width,
            height: AppQuery.instance.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: AppColors.black.withOpacity(0.3),
                child: view,
              ),
            ),
          );

          return PopScope(
            canPop: !disableBackButton,
            child: content,
          );
        });
  }

  /// Dialog end
  void dismissCurrentPopUp() {
    if (currentDialogContext != null) {
      try {
        Navigator.of(currentDialogContext!).pop();
      } catch (_) {}
    }
    resetPopUp();
  }

  void resetPopUp() {
    currentDialogContext = null;
    loadingDialogContext = null;
  }
}
