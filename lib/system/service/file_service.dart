// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_weaver/data/model/internal/file_content_model.dart';

import '../popup/dialog.dart';
import 'bug_tracker.dart';
import 'local_logger.dart';

class FileService {
  final AppLocalLogger _logger = AppLocalLogger('FileUtils');

  /// Internal Dir Start
  Future<bool> createInternalDirectory(String directoryName) async {
    final Directory baseDir = await getApplicationDocumentsDirectory();

    final String directoryPath = join(baseDir.path, directoryName);
    final Directory newDirectory = Directory(directoryPath);

    final bool dirExist = newDirectory.existsSync();

    if (!dirExist) {
      await newDirectory.create(recursive: true);
    }
    return true;
  }

  Future<bool> deleteInternalDirectory(String directoryName) async {
    final Directory baseDir = await getApplicationDocumentsDirectory();

    final String directoryPath = join(baseDir.path, directoryName);
    final Directory newDirectory = Directory(directoryPath);

    final bool dirExist = newDirectory.existsSync();

    if (!dirExist) {
      await newDirectory.delete(recursive: true);
    }
    return true;
  }

  Future<File?> createInternalDirTxtFile(String text) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/kfi-bug-tracker.txt');
      final File newFile = await file.writeAsString(text);
      return File(newFile.path);
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return null;
    }
  }

  Future<File?> createInternalDirFile(
      String directoryName, String fileName, String content) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$directoryName/$fileName');
      final File newFile = await file.writeAsString(content);
      return File(newFile.path);
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return null;
    }
  }

  Future<bool> deleteInternalDirFile(
      String directoryName, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$directoryName/$fileName');
      await file.delete();
      return true;
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return false;
    }
  }

  Future<File?> getInternalDirFile(
      String directoryName, String fileName) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/$directoryName/$fileName');
      return file;
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return null;
    }
  }

  Future<String> getInternalDirFileContentAsString(
      String directoryName, String fileName) async {
    try {
      final File? file = await getInternalDirFile(directoryName, fileName);
      if (file != null) {
        return file.readAsString();
      } else {
        return '';
      }
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return '';
    }
  }

  Future<List<FileContentModel>> getListOfInternalDirFileContentAsString(
      String directoryName) async {
    final List<FileContentModel> result = [];
    try {
      final baseDir = await getApplicationDocumentsDirectory();
      final String directoryPath = join(baseDir.path, directoryName);
      final Directory newDirectory = Directory(directoryPath);
      final List<FileSystemEntity> fileList = newDirectory.listSync();

      for (final FileSystemEntity item in fileList) {
        if (item is File) {
          final String content = await item.readAsString();
          result.add(
            FileContentModel(
              filePath: item.path,
              content: content,
            ),
          );
        }
      }
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    }
    return result;
  }

  /// Internal Dir End

  /// External Dir Start
  Future<bool> createExternalDirectory(String directoryName) async {
    final String appDirPath = await getAppExternalDirectoryPath();
    final String newDirPath = '$appDirPath/$directoryName';

    final Directory appDirectory = Directory(newDirPath);
    if (!appDirectory.existsSync()) {
      await appDirectory.create(recursive: true);
    }
    return true;
  }

  Future<bool> deleteExternalDirectory(String directoryName) async {
    final String appDirPath = await getAppExternalDirectoryPath();
    final String newDirPath = '$appDirPath/$directoryName';

    final Directory appDirectory = Directory(newDirPath);
    if (!appDirectory.existsSync()) {
      await appDirectory.delete(recursive: true);
    }
    return true;
  }

  Future<File?> createExternalDirFile(
      String directoryName, String fileName, String content) async {
    try {
      final String appDirPath = await getAppExternalDirectoryPath();
      final File file = File('$appDirPath/$directoryName/$fileName');
      final File newFile = await file.writeAsString(content);
      return File(newFile.path);
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
      return null;
    }
  }

  Future<File?> getExternalDirFile(
    String directoryName,
    String fileName, {
    bool checkFileExist = false,
  }) async {
    try {
      final String appDirPath = await getAppExternalDirectoryPath();

      if (checkFileExist) {
        // ignore: avoid_slow_async_io
        final bool fileExists =
            await File('$appDirPath/$directoryName/$fileName').exists();
        if (!fileExists) {
          return null;
        }
      }

      final File file = File('$appDirPath/$directoryName/$fileName');
      return file;
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    } catch (e, s) {
      AppBugTracker.instance.captureException(stackTrace: s);
    }
    return null;
  }

  Future<String> getExternalDirFileContentAsString(
    String directoryName,
    String fileName, {
    bool checkFileExist = false,
  }) async {
    try {
      final File? file = await getExternalDirFile(directoryName, fileName,
          checkFileExist: checkFileExist);
      if (file != null) {
        return file.readAsString();
      } else {
        return '';
      }
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    } catch (e, s) {
      AppBugTracker.instance.captureException(stackTrace: s);
    }
    return '';
  }

  Future<String> getAppExternalDirectoryPath() async {
    final String path = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOCUMENTS,
    );

    final String appDirectoryPath = '$path/KairosLos';
    return appDirectoryPath;
  }

  Future<bool> checkExternalDirectoryPermission(BuildContext context) async {
    final PermissionStatus status =
        await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      return true;
    } else {
      if (context.mounted) {
        bool denied = false;
        await AppDialog.instance.sConfirmation(
          context: context,
          detail:
              'Offline mode membutuhkan akses permission untuk mengakses file storage anda '
              'untuk kebutuhan membuat file offline yang nantinya akan di upload ke server.',
          confirmText: 'Berikan',
          confirmCallback: () async {
            AppDialog.instance.dismissCurrentPopUp();
          },
          cancelText: 'Tolak',
          cancelCallback: () {
            AppDialog.instance.dismissCurrentPopUp();
            denied = true;
          },
        );

        if (denied) {
          return false;
        }
        final PermissionStatus newStatus =
            await Permission.manageExternalStorage.request();
        if (newStatus.isGranted) {
          return true;
        } else {
          if (context.mounted) {
            return await checkExternalDirectoryPermission(context);
          }
        }
      }
    }
    return false;
  }

  /// External Dir End

  String? getFileName(File file) {
    if (file.path.isEmpty) {
      return null;
    } else {
      return file.path.split('/').last.replaceAll('.${getFileExt(file)}', '');
    }
  }

  String? getFileExt(File file) {
    if (file.path.isEmpty) {
      return null;
    } else {
      return extension(file.path).replaceAll('.', '');
    }
  }

  String getImageExtAsString(ImageExt ext) {
    if (ext == ImageExt.png) {
      return 'png';
    } else {
      return 'jpg';
    }
  }

  String? getFilePath(File file) {
    if (file.path.isEmpty) {
      return null;
    } else {
      return file.path.replaceAll('/${getFileNameAndExt(file)}', '');
    }
  }

  String? getFileNameAndExt(File file) {
    if (file.path.isEmpty) {
      return null;
    } else {
      return '${getFileName(file)!}.${getFileExt(file)!}';
    }
  }

  Future<String?> convertFileToBase64(File? file) async {
    if (file == null) {
      return null;
    } else {
      try {
        final List<int> imageBytes = await file.readAsBytes();
        return base64Encode(imageBytes);
      } catch (e) {
        _printDebug('_convertFileToBase64 error due to $e');
        return null;
      }
    }
  }

  void _printDebug(String print) => _logger.printDebug(print);
}

enum ImageExt { jpg, jpeg, png }
