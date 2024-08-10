class StoryBreakdownModel {
  StoryMetadata? storyMetadata;
  PlotBreakdown? plotBreakdown;
  SettingBreakdown? settingBreakdown;
  List<CharacterBreakdown>? characterBreakdown;
  List<ChapterBreakdown>? chapterBreakdown;
  String? jsonString;
  String? fileName;

  StoryBreakdownModel({
    this.storyMetadata,
    this.characterBreakdown,
    this.plotBreakdown,
    this.settingBreakdown,
    this.chapterBreakdown,
    this.jsonString,
  });

  StoryBreakdownModel.fromJson(Map<String, dynamic> json) {
    storyMetadata = json['storyMetadata'] != null
        ? StoryMetadata.fromJson(json['storyMetadata'])
        : null;
    if (json['characterBreakdown'] != null) {
      characterBreakdown = <CharacterBreakdown>[];
      json['characterBreakdown'].forEach((v) {
        characterBreakdown!.add(CharacterBreakdown.fromJson(v));
      });
    }
    plotBreakdown = json['plotBreakdown'] != null
        ? PlotBreakdown.fromJson(json['plotBreakdown'])
        : null;
    settingBreakdown = json['settingBreakdown'] != null
        ? SettingBreakdown.fromJson(json['settingBreakdown'])
        : null;
    if (json['chapterBreakdown'] != null) {
      chapterBreakdown = <ChapterBreakdown>[];
      json['chapterBreakdown'].forEach((v) {
        chapterBreakdown!.add(ChapterBreakdown.fromJson(v));
      });
    }
    jsonString = json['jsonString'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storyMetadata != null) {
      data['storyMetadata'] = storyMetadata!.toJson();
    }
    if (characterBreakdown != null) {
      data['characterBreakdown'] =
          characterBreakdown!.map((v) => v.toJson()).toList();
    }
    if (plotBreakdown != null) {
      data['plotBreakdown'] = plotBreakdown!.toJson();
    }
    if (settingBreakdown != null) {
      data['settingBreakdown'] = settingBreakdown!.toJson();
    }
    if (chapterBreakdown != null) {
      data['chapterBreakdown'] =
          chapterBreakdown!.map((v) => v.toJson()).toList();
    }
    jsonString = data['jsonString'];
    return data;
  }

  Map<String, dynamic> toJsonAi() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storyMetadata != null) {
      data['storyMetadata'] = storyMetadata!.toJson();
    }
    if (characterBreakdown != null) {
      data['characterBreakdown'] =
          characterBreakdown!.map((v) => v.toJson()).toList();
    }
    if (plotBreakdown != null) {
      data['plotBreakdown'] = plotBreakdown!.toJson();
    }
    if (settingBreakdown != null) {
      data['settingBreakdown'] = settingBreakdown!.toJson();
    }
    if (chapterBreakdown != null) {
      data['chapterBreakdown'] = chapterBreakdown!.map((v) {
        Map<dynamic, dynamic> json = v.toJson();
        json.remove('chapterStory');
        return json;
      }).toList();
    }
    jsonString = data['jsonString'];
    return data;
  }

  Map<String, dynamic> cleanToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storyMetadata != null) {
      data['storyMetadata'] = storyMetadata!.toJson();
    }
    if (characterBreakdown != null) {
      data['characterBreakdown'] =
          characterBreakdown!.map((v) => v.toJson()).toList();
    }
    if (plotBreakdown != null) {
      data['plotBreakdown'] = plotBreakdown!.toJson();
    }
    if (settingBreakdown != null) {
      data['settingBreakdown'] = settingBreakdown!.toJson();
    }
    if (chapterBreakdown != null) {
      data['chapterBreakdown'] =
          chapterBreakdown!.map((v) => v.toJson()).toList();
    }
    jsonString = data['jsonString'];

    _cleanMap(data);
    return data;
  }

  void _cleanMap(Map<dynamic, dynamic> map) {
    map.removeWhere((key, value) {
      if (value == null) {
        return true;
      } else if (value is String && value.isEmpty) {
        return true;
      } else if (value is List && value.isEmpty) {
        return true;
      } else if (value is Map) {
        _cleanMap(value);
        return value.isEmpty; // Remove the map if it's empty after cleaning
      } else if (value is List) {
        value.removeWhere((element) {
          if (element is Map) {
            _cleanMap(element);
            return element
                .isEmpty; // Remove the map if it's empty after cleaning
          }
          return false;
        });
        return value.isEmpty; // Remove the list if it's empty after cleaning
      }
      return false;
    });
  }

  int get nextChapter => (chapterBreakdown ?? []).length + 1;
}

class StoryMetadata {
  String? title;
  String? author;
  String? goal;
  List<String>? genre;
  List<String>? themes;
  List<String>? setting;
  String? wordCount;
  String? creationDate;
  List<String>? storyTone;
  List<String>? storyArcs;
  List<String>? symbolism;
  List<String>? storyStyle;
  List<String>? targetAudience;
  List<String>? worldbuildingDetails;
  List<String>? storyConflicts;
  List<String>? themesAndMotifs;
  List<String>? storyPacing;

  StoryMetadata(
      {this.title,
      this.author,
      this.goal,
      this.genre,
      this.themes,
      this.setting,
      this.wordCount,
      this.creationDate,
      this.storyTone,
      this.storyArcs,
      this.symbolism,
      this.storyStyle,
      this.targetAudience,
      this.worldbuildingDetails,
      this.storyConflicts,
      this.themesAndMotifs,
      this.storyPacing});

  StoryMetadata.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    goal = json['goal'];
    genre = json['genre']?.cast<String>();
    themes = json['themes']?.cast<String>();
    setting = json['setting']?.cast<String>();
    wordCount = json['wordCount'];
    creationDate = json['creationDate'];
    storyTone = json['storyTone']?.cast<String>();
    storyArcs = json['storyArcs']?.cast<String>();
    symbolism = json['symbolism']?.cast<String>();
    storyStyle = json['storyStyle']?.cast<String>();
    targetAudience = json['targetAudience']?.cast<String>();
    worldbuildingDetails = json['worldbuildingDetails']?.cast<String>();
    storyConflicts = json['storyConflicts']?.cast<String>();
    themesAndMotifs = json['themesAndMotifs']?.cast<String>();
    storyPacing = json['storyPacing']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['goal'] = goal;
    data['genre'] = genre;
    data['themes'] = themes;
    data['setting'] = setting;
    data['wordCount'] = wordCount;
    data['creationDate'] = creationDate;
    data['storyTone'] = storyTone;
    data['storyArcs'] = storyArcs;
    data['symbolism'] = symbolism;
    data['storyStyle'] = storyStyle;
    data['targetAudience'] = targetAudience;
    data['worldbuildingDetails'] = worldbuildingDetails;
    data['storyConflicts'] = storyConflicts;
    data['themesAndMotifs'] = themesAndMotifs;
    data['storyPacing'] = storyPacing;
    return data;
  }
}

class CharacterBreakdown {
  String? name;
  String? description;
  String? appearance;
  List<String>? personality;
  List<Relationships>? relationships;
  String? backstory;
  List<String>? goals;

  CharacterBreakdown(
      {this.name,
      this.description,
      this.appearance,
      this.personality,
      this.relationships,
      this.backstory,
      this.goals});

  CharacterBreakdown.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    appearance = json['appearance'];
    personality = json['personality']?.cast<String>();
    if (json['relationships'] != null) {
      relationships = <Relationships>[];
      json['relationships'].forEach((v) {
        relationships!.add(Relationships.fromJson(v));
      });
    }
    backstory = json['backstory'];
    goals = json['goals']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['appearance'] = appearance;
    data['personality'] = personality;
    if (relationships != null) {
      data['relationships'] = relationships!.map((v) => v.toJson()).toList();
    }
    data['backstory'] = backstory;
    data['goals'] = goals;
    return data;
  }
}

class Relationships {
  String? type;
  String? description;

  Relationships({this.type, this.description});

  Relationships.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}

class PlotBreakdown {
  String? incitingIncident;
  String? risingAction;
  String? climax;
  String? fallingAction;
  String? resolution;

  PlotBreakdown(
      {this.incitingIncident,
      this.risingAction,
      this.climax,
      this.fallingAction,
      this.resolution});

  PlotBreakdown.fromJson(Map<String, dynamic> json) {
    incitingIncident = json['incitingIncident'];
    risingAction = json['risingAction'];
    climax = json['climax'];
    fallingAction = json['fallingAction'];
    resolution = json['resolution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['incitingIncident'] = incitingIncident;
    data['risingAction'] = risingAction;
    data['climax'] = climax;
    data['fallingAction'] = fallingAction;
    data['resolution'] = resolution;
    return data;
  }
}

class SettingBreakdown {
  List<dynamic>? locations;
  List<dynamic>? culturalElements;

  SettingBreakdown({this.locations, this.culturalElements});

  SettingBreakdown.fromJson(Map<String, dynamic> json) {
    if (json['locations'] is String) {
      locations = [json['locations']];
    } else {
      locations = json['locations'];
    }

    if (json['culturalElements'] is String) {
      culturalElements = [json['culturalElements']];
    } else {
      culturalElements = json['culturalElements'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locations'] = locations;
    data['culturalElements'] = culturalElements;
    return data;
  }
}

class ChapterBreakdown {
  int? number;
  String? title;
  String? summary;
  List<dynamic>? keyElements;
  String? chapterStory;
  List<dynamic>? tags;

  ChapterBreakdown(
      {this.number,
      this.title,
      this.summary,
      this.keyElements,
      this.tags,
      this.chapterStory});

  ChapterBreakdown.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    title = json['title'];
    summary = json['summary'];
    if (json['keyElements'] is String) {
      keyElements = [json['keyElements']];
    } else {
      keyElements = json['keyElements'];
    }
    chapterStory = json['chapterStory'];
    tags = json['tags']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['title'] = title;
    data['summary'] = summary;
    data['keyElements'] = keyElements;
    data['chapterStory'] = chapterStory;
    data['tags'] = tags;
    return data;
  }
}
