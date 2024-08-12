import 'dart:convert';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:story_weaver/app/screen/home/home_vm.dart';
import 'package:story_weaver/data/ai-schema/story_breakdown_schema.dart';
import 'package:story_weaver/data/model/story/story_breakdown_model.dart';
import 'package:story_weaver/system/exception/ai_exception.dart';
import 'package:story_weaver/system/global_extension.dart';
import 'package:story_weaver/system/service/local_storage.dart';

import '../../data/ai-schema/system_introduction_schema.dart';

class AiService {
  factory AiService() => instance;

  AiService._();

  /// Singleton factory
  static final AiService instance = AiService._();

  // ignore: non_constant_identifier_names
  final AI = Gemini.instance;
  List<GeminiModel>? geminiList;

  bool isInitDone = false;

  Future<void> init() async {
    if (!isInitDone) {
      await AI.text(
        systemIntroductionShcema(HomeVm.instance.userName.toString()),
        generationConfig: GenerationConfig(
          temperature: 0.75,
          maxOutputTokens: 512,
        ),
      );
      isInitDone = true;
    }
  }

  /// Only generate story as a text
  Future<String> generateInitialStory(
    StoryBreakdownModel storyBreakdownModel,
  ) async {
    final String query = '''
      Generate an initial story with no more than 150 words and split into 3 paragraphs, 
      describing the character, setting, main issue, and themes, based on this story breakdown.
      Story breakdown :${storyBreakdownModel.toJsonAi()}
      ''';

    return await _basicQuery(query);
  }

  /// Only generate story as a text
  Future<String> continueStory(
    StoryBreakdownModel storyBreakdownModel,
    String? storyHighlight,
  ) async {
    final String query = '''
      Generate a new chapter, ${storyBreakdownModel.nextChapter}, for the story.
      The story generated should be no more than 150 words and split into 3 paragraphs, based on this story breakdown.
      ${storyHighlight.isNotNullOrEmpty ? 'Highlight this $storyHighlight in the story generation.' : null}
      Story breakdown :${storyBreakdownModel.toJsonAi()}
      ''';
    return await _basicQuery(query);
  }

  /// Generate latest story breakdown
  Future<String> generateLatestStoryBreakdown(
    StoryBreakdownModel storyBreakdownModel,
    String lastStory,
  ) async {
    String chapterBreakdownJsonString =
        jsonEncode(storyBreakdownModel.toJsonAi());
    String query = '''
      Sample JSON Output : $storyBreakdownSample
      Current story breakdown : $chapterBreakdownJsonString
      The story: $lastStory      

      Commands : 
      1.Summarize the story into chapter ${storyBreakdownModel.nextChapter} 
      with no more than 25 words, including title with chapter and summary.
      2.Add the chapter summary into the chapter breakdown.
      3.Summarize the story progress, plot, and detail changes.
      4.Summarize changes in characters, setting, and main issue.
      5.Your output should match the schema of the sample JSON with the exact same data type.
      6.Your output SHOULD BE IN JSON format only, no need to add more context.
      ''';

    String? response;
    response = await _basicQuery(query);
    return response;
  }

  Future<String> regenerateErrorStoryBreakdown(
    StoryBreakdownModel lastStoryBreakdownModel,
    List<String> errorList,
  ) async {
    final newResponse = await _basicQuery(
      '''
        This JSON you generated has error :
        ${errorList.map((item) => '$item\n')}
        Please fix it and regenerate it again with the 
        same request I mentioned before as JSON.
        ''',
    );
    return newResponse;
  }

  Future<String> generateNextChapter(String text) async {
    return await _basicQuery(text);
  }

  Future<String> getOptions(String title, String detail) async {
    final String query =
        'please generate string of options as json array for \n'
        'title of $title and detail of $detail,\n';
    return await _basicQuery(query);
  }

  Future<String> _basicQuery(
    String query,
  ) async {
    await init();
    final response = await AI.text(
      query,
      modelName: AppLocalStorage.instance.geminiModelId,
      safetySettings: [
        SafetySetting(
          category: SafetyCategory.harassment,
          threshold: SafetyThreshold.blockNone,
        ),
        SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockNone,
        ),
        SafetySetting(
          category: SafetyCategory.sexuallyExplicit,
          threshold: SafetyThreshold.blockNone,
        ),
        SafetySetting(
          category: SafetyCategory.dangerous,
          threshold: SafetyThreshold.blockNone,
        ),
      ],
    );

    if (response == null || response.output.isNullOrEmpty) {
      throw AiGlobalException(
          'Failed to generate output, please try regenerate again.');
    } else {
      return response.output!
          .replaceAll('```json', '')
          .replaceAll('```JSON', '')
          .replaceAll('```', '')
          .replaceAll('*', '')
          .replaceAll('#', '');
    }
  }
}
