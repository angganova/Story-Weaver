import 'package:flutter/material.dart';
import 'package:story_weaver/data/model/main/title_detail_model.dart';
import 'package:story_weaver/system/global_extension.dart';

import 'story_breakdown_model.dart';

enum DataType {
  singleText,
  array,
}

enum InputType {
  textField,
  arrayOfObject,
  multiSelect,
}

class StoryPreparationModel {
  List<StoryPreparationDetail>? storyPreparationList;
  List<String> characterNameList = [];

  StoryPreparationModel({this.storyPreparationList});

  factory StoryPreparationModel.initial() {
    StoryPreparationModel result =
        StoryPreparationModel.fromJson(_storyPreparationData);

    for (var item in result.storyPreparationList!) {
      if (item.dataType.ignoreCase('string')) {
        item.tc = TextEditingController();
      } else if (item.dataType.ignoreCase('split-string')) {
        item.tc = TextEditingController();
      }
    }

    return result;
  }

  StoryBreakdownModel finish() {
    for (var item in storyPreparationList!) {
      if (item.tc != null) {
        item.value = item.tc!.text;
      }
    }

    final StoryBreakdownModel result = StoryBreakdownModel();
    StoryMetadata storyMetadata = StoryMetadata();

    storyMetadata.title = storyPreparationList?[0].value;
    storyMetadata.goal = storyPreparationList?[1].value;

    storyMetadata.targetAudience = storyPreparationList?[3]
        .internalOptionList
        .where((item) => item.selected)
        .map((item) => item.title ?? '')
        .toList();
    storyMetadata.genre = storyPreparationList?[4]
        .internalOptionList
        .where((item) => item.selected)
        .map((item) => item.title ?? '')
        .toList();
    storyMetadata.setting = storyPreparationList?[5]
        .internalOptionList
        .where((item) => item.selected)
        .map((item) => item.title ?? '')
        .toList();
    storyMetadata.themes = storyPreparationList?[6]
        .internalOptionList
        .where((item) => item.selected)
        .map((item) => item.title ?? '')
        .toList();
    storyMetadata.storyStyle = storyPreparationList?[7]
        .internalOptionList
        .where((item) => item.selected)
        .map((item) => item.title ?? '')
        .toList();

    result.storyMetadata = storyMetadata;
    result.characterBreakdown = [
      ...characterNameList.map((item) => CharacterBreakdown(name: item)),
    ];

    return result;
  }

  StoryPreparationModel.fromJson(Map<String, dynamic> json) {
    if (json['story preparation'] != null) {
      storyPreparationList = <StoryPreparationDetail>[];
      json['story preparation'].forEach((v) {
        final StoryPreparationDetail detail =
            StoryPreparationDetail.fromJson(v);
        storyPreparationList!.add(detail);
      });
    } else {
      storyPreparationList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (storyPreparationList != null) {
      data['story preparation'] =
          storyPreparationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryPreparationDetail {
  String? title;
  String? description;
  String? value;
  String? dataType;

  TextEditingController? tc;

  List<String> optionList = [];
  List<String> selectedOptions = [];

  List<TitleDetailModel> internalOptionList = [];

  StoryPreparationDetail({this.title, this.description, this.value});

  StoryPreparationDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    dataType = json['dataType'];

    if (json['internalOptionList'] != null) {
      internalOptionList = <TitleDetailModel>[];
      json['internalOptionList'].forEach((v) {
        final TitleDetailModel detail = TitleDetailModel.fromJson(v);
        internalOptionList.add(detail);
      });
    } else {
      internalOptionList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['value'] = value;
    data['dataType'] = dataType;
    return data;
  }
}

const _storyPreparationData = {
  "story preparation": [
    {
      "title": "Title",
      "description": "What is the title of the story?",
      "value": "",
      "dataType": "string"
    },
    {
      "title": "The Goal",
      "description":
          "What is the purpose of this story? Is it to entertain, to teach a lesson, to explore a specific theme, or to simply express creativity? Having a clear goal will help to guide the story's development.",
      "value": "",
      "dataType": "string"
    },
    {
      "title": "The Characters",
      "description":
          "Who are the main characters in the story? What are their personalities, motivations, and goals? Developing strong characters is essential for a compelling story.\nInput multiple characters can separated by coma (,).",
      "value": "",
      "dataType": "split-string",
    },
    {
      "title": "The Audience",
      "description":
          "Who is this story for? Is it for children, adults, or a specific demographic? Knowing the target audience will help to determine the appropriate tone, language, and themes.",
      "value": "",
      "dataType": "internalOption",
      "internalOptionList": [
        {
          "title": "General Audience",
          "detail":
              "Stories suitable for a wide range of audiences, often focusing on universal themes and accessible language."
        },
        {
          "title": "Children",
          "detail":
              "Stories specifically written for children, often involving simple language and positive messages."
        },
        {
          "title": "Young Adults",
          "detail":
              "Stories targeting teenagers and young adults, often exploring themes of self-discovery, relationships, and personal growth."
        },
        {
          "title": "Adults",
          "detail":
              "Stories written for an adult audience, often involving complex themes and mature content."
        },
        {
          "title": "Seniors",
          "detail":
              "Stories tailored for older adults, often involving themes of nostalgia, life experience, and reflection."
        }
      ],
    },
    {
      "title": "The Genre",
      "description":
          "What genre will the story be? This will help to determine the story's setting, characters, plot, and tone.",
      "value": "",
      "dataType": "internalOption",
      "internalOptionList": [
        {
          "title": "Science Fiction",
          "detail":
              "A story set in the future or in a different world, often involving advanced technology and space travel."
        },
        {
          "title": "Fantasy",
          "detail":
              "A story set in a world of magic and mythical creatures, often involving quests and battles."
        },
        {
          "title": "Mystery",
          "detail":
              "A story involving a crime or puzzle that needs to be solved, often featuring detectives or private investigators."
        },
        {
          "title": "Romance",
          "detail":
              "A story focused on the development of a romantic relationship between two characters."
        },
        {
          "title": "Historical Fiction",
          "detail":
              "A story set in a past time period, often based on real events and characters."
        },
        {
          "title": "Horror",
          "detail":
              "A story designed to scare or disgust the reader, often involving supernatural elements."
        },
        {
          "title": "Thriller",
          "detail":
              "A story that keeps the reader on the edge of their seat, often involving suspense and danger."
        },
        {
          "title": "Comedy",
          "detail":
              "A story that is designed to make the reader laugh, often involving humor and lighthearted situations."
        },
        {
          "title": "Dystopian",
          "detail":
              "A story set in a futuristic society that is characterized by poverty, oppression, and environmental degradation."
        },
        {
          "title": "Utopian",
          "detail":
              "A story set in a futuristic society that is characterized by peace, equality, and prosperity."
        }
      ],
    },
    {
      "title": "The Setting",
      "description":
          "Where and when will the story take place? The setting can have a significant impact on the story's themes, characters, and plot.",
      "value": "",
      "dataType": "internalOption",
      "internalOptionList": [
        {
          "title": "Historical",
          "detail":
              "A story set in a specific time period in the past, often involving real events or historical figures."
        },
        {
          "title": "Modern Day",
          "detail":
              "A story set in the present time, reflecting current societal norms, technology, and culture."
        },
        {
          "title": "Future",
          "detail":
              "A story set in the future, often involving advanced technology, space exploration, or futuristic societies."
        },
        {
          "title": "Alternate Reality",
          "detail":
              "A story set in a world that is similar to ours but with significant differences, often involving speculative elements."
        },
        {
          "title": "Fantasy World",
          "detail":
              "A story set in a completely fictional world, often involving magic, mythical creatures, and fantastical elements."
        },
        {
          "title": "Post-Apocalyptic",
          "detail":
              "A story set in a world after a major catastrophe, often involving survival in a harsh and dangerous environment."
        },
        {
          "title": "Urban",
          "detail":
              "A story set in a city environment, often involving the hustle and bustle of urban life."
        },
        {
          "title": "Rural",
          "detail":
              "A story set in the countryside or a small town, often involving close-knit communities and natural settings."
        },
        {
          "title": "Outer Space",
          "detail":
              "A story set in space, often involving space travel, exploration, and encounters with alien life."
        },
        {
          "title": "Virtual Reality",
          "detail":
              "A story set within a digital or simulated environment, often involving advanced technology and virtual experiences."
        }
      ],
    },
    {
      "title": "The Themes",
      "description":
          "What are the main themes or ideas that the story explores? Themes can add depth and meaning to the story, making it more than just a simple entertainment.",
      "value": "",
      "dataType": "internalOption",
      "internalOptionList": [
        {
          "title": "Love",
          "detail":
              "Explores the various aspects of love, such as romantic love, familial love, or self-love."
        },
        {
          "title": "Friendship",
          "detail":
              "Highlights the importance and complexities of friendships and human connections."
        },
        {
          "title": "Good vs. Evil",
          "detail":
              "Depicts the struggle between good and evil forces, often with clear moral implications."
        },
        {
          "title": "Courage",
          "detail":
              "Showcases characters displaying bravery in the face of danger, fear, or adversity."
        },
        {
          "title": "Redemption",
          "detail":
              "Focuses on characters seeking forgiveness or making amends for past wrongs."
        },
        {
          "title": "Identity",
          "detail":
              "Explores characters' search for self-discovery and understanding of who they are."
        },
        {
          "title": "Freedom",
          "detail":
              "Examines the desire for freedom and the struggle against oppression or confinement."
        },
        {
          "title": "Survival",
          "detail":
              "Centers on characters fighting to stay alive in challenging or hostile environments."
        },
        {
          "title": "Power and Corruption",
          "detail":
              "Looks at how power can corrupt individuals or societies, and the consequences of such corruption."
        },
        {
          "title": "Coming of Age",
          "detail":
              "Follows characters as they grow and mature, often dealing with the challenges of transitioning from youth to adulthood."
        }
      ],
    },
    {
      "title": "The Style",
      "description":
          "What is the overall writing style of the story? Is it formal, informal, descriptive, action-oriented, or something else? The writing style should be consistent with the genre, tone, and target audience.",
      "value": "",
      "dataType": "internalOption",
      "internalOptionList": [
        {
          "title": "Formal",
          "detail":
              "The story is written in a formal tone, with sophisticated language and a structured format."
        },
        {
          "title": "Informal",
          "detail":
              "The story uses a casual tone, with conversational language and a relaxed format."
        },
        {
          "title": "Descriptive",
          "detail":
              "The writing style is rich in detail, painting vivid pictures of settings, characters, and actions."
        },
        {
          "title": "Action-oriented",
          "detail":
              "The story focuses on dynamic and fast-paced events, with emphasis on physical actions and exciting sequences."
        },
        {
          "title": "Narrative",
          "detail":
              "The story is told through a clear and structured narration, guiding the reader through events in a logical manner."
        },
        {
          "title": "Dialogue-driven",
          "detail":
              "The story is heavily based on dialogue between characters, revealing the plot and character dynamics through their conversations."
        },
        {
          "title": "Expository",
          "detail":
              "The writing style explains and provides background information, focusing on clarity and understanding."
        },
        {
          "title": "Persuasive",
          "detail":
              "The story aims to convince the reader of a particular point of view or argument, using rhetorical techniques."
        },
        {
          "title": "Reflective",
          "detail":
              "The story delves into the thoughts and feelings of characters, providing introspection and personal insight."
        },
        {
          "title": "Satirical",
          "detail":
              "The story uses humor, irony, and exaggeration to critique or mock societal norms and human behavior."
        }
      ],
    }
  ]
};
