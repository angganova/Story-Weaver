import 'dart:convert';

import 'package:story_weaver/data/model/internal/file_content_model.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/service/bug_tracker.dart';
import 'package:story_weaver/system/service/file_service.dart';

import '../../../data/model/story/story_breakdown_model.dart';

class StoryFileManagement {
  factory StoryFileManagement() => instance;

  StoryFileManagement._();

  /// Singleton factory
  static final StoryFileManagement instance = StoryFileManagement._();

  final FileService _fileService = FileService();

  final String _directoryName = 'story-weaver/stories';
  final String _rootFileName = 'story-';
  final String _fileExt = '.json';

  Future<bool> saveStory(
    StoryBreakdownModel storyBreakdownModel, {
    String? title,
  }) async {
    await _fileService.createInternalDirectory(_directoryName);
    String? finalTitle = title ?? storyBreakdownModel.storyMetadata?.title;

    if (finalTitle.isNullOrEmpty) {
      return false;
    }

    try {
      String? fileName =
          '$_rootFileName${title ?? storyBreakdownModel.storyMetadata?.title}$_fileExt';
      storyBreakdownModel.fileName = fileName;
      String? jsonStringToSave = jsonEncode(storyBreakdownModel.toJson());
      await _fileService.createInternalDirFile(
          _directoryName, fileName, jsonStringToSave);
      return true;
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    }
    return false;
  }

  Future<List<StoryBreakdownModel>> getStoryList() async {
    List<FileContentModel> fileContentList = await _fileService
        .getListOfInternalDirFileContentAsString(_directoryName);
    List<StoryBreakdownModel> result = [];

    try {
      if (fileContentList.isNotNullOrEmpty) {
        for (var item in fileContentList) {
          final Map<String, dynamic> retrievedData = jsonDecode(item.content);
          final StoryBreakdownModel storyBreakdownModel =
              StoryBreakdownModel.fromJson(retrievedData)
                ..fileName = item.filePath?.split('/').last;
          result.add(storyBreakdownModel);
        }
      }
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    }

    return result;
  }

  Future<bool> deleteStory(String fileName) async {
    try {
      await _fileService.deleteInternalDirFile(_directoryName, fileName);
      return true;
    } on Exception catch (e, s) {
      AppBugTracker.instance.captureException(exception: e, stackTrace: s);
    }

    return false;
  }
}
