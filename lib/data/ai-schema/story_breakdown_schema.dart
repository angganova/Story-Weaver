const storyBreakdownShcema = '''
Story Metadata:
* Title: The user can search for stories by title, or the system can suggest titles based on the story's genre, themes, or setting.
* Author: The user can filter stories by author, or the system can track the user's own stories.
* Genre: The user can filter stories by genre, or the system can suggest genres based on the story's themes or setting.
* Themes: The user can filter stories by theme, or the system can suggest themes based on the story's genre or setting.
* Setting: The user can filter stories by setting, or the system can suggest settings based on the story's genre or themes.
* Word Count: The user can filter stories by word count, or the system can track the user's progress on a story.
* Creation Date: The system can track the user's progress on a story and provide insights into their writing habits.
* Story Tone: The system can generate descriptions or scenes that are consistent with the story's tone. For example, if the story tone is "melancholic," the system might generate a scene that is sad or reflective.
* Story Arcs: The system can help the user to structure their story by suggesting plot points or events that are consistent with the story's arcs. For example, if the story arc is "Adi's journey of self-discovery," the system might suggest a scene where Adi learns something new about himself.
* Symbolism: The system can generate descriptions or scenes that incorporate the story's symbolism. For example, if the banyan tree symbolizes a sanctuary, the system might generate a scene where the characters find refuge under the tree.
* Story Style: The system can suggest writing styles based on the story's genre, themes, or target audience. For example, if the story is a fantasy adventure, the system might suggest a more descriptive and evocative style.
* Target Audience: The system can help the user to tailor their story to a specific audience by suggesting themes, settings, and language that are appropriate for that audience.
* Worldbuilding Details: The system can help the user to create a detailed and believable fictional world by suggesting information about the world's history, geography, culture, and magic systems.
* Story Conflicts: What are the main conflicts in the story? This can help to create tension and drive the plot forward.
* Themes and Motifs: It might be helpful to have a more detailed breakdown of the story's themes and motifs, including how they are developed and resolved throughout the story.
* Story Pacing: This would capture the overall pace of the story. Is it fast-paced, slow-paced, or a mix of both? Knowing the story pacing can help guide the system in generating text that is consistent with the story's rhythm.
Character Breakdown:
* Name: The name of the character.
* Appearance: A detailed description of the character's physical appearance, including their height, build, hair color, eye color, clothing, and any other distinctive features.
* Personality: A description of the character's personality traits, including their strengths, weaknesses, values, beliefs, and motivations.
* Relationships: The system can generate dialogue or scenes that are consistent with the characters' relationships. For example, a scene between Adi and his grandmother would be different from a scene between Adi and Mysha.
    * Relationship Type: (e.g., romantic, familial, antagonistic)
    * Relationship Description: (e.g., "Adi and his grandmother share a deep bond of love and respect")
* Backstory: The system can help the user to develop detailed backstories for their characters, including their family, upbringing, and any significant events that shaped their personality.
* Goals: What are the characters' motivations and goals? This can help to drive the plot and create conflict.
Plot Breakdown:
* Inciting Incident: The system can help the user to come up with an inciting incident that is relevant to the story's themes and setting.
* Rising Action: The system can help the user to generate plot points that build tension and lead to the climax.
* Climax: The system can help the user to generate a climax that is consistent with the story's themes and characters.
* Falling Action: The system can help the user to generate plot points that resolve the conflict and lead to the resolution.
* Resolution: The system can help the user to generate a resolution that is satisfying and consistent with the story's themes.
Setting Breakdown:
* Locations: The system can generate descriptions of locations that are consistent with the story's setting.
* Cultural Elements: The system can generate descriptions, scenes, and dialogue that are consistent with the story's cultural elements. For example, if the story is set in Java, the system might generate a scene that includes a gamelan orchestra or a traditional Javanese dance.
Chapter Breakdown:
* Title: The system can suggest titles for chapters based on the chapter's theme or key events.
* Summary: The system can generate summaries of chapters that are consistent with the chapter's key elements.
* Key Elements: The system can help the user to identify the key elements of each chapter, such as the main conflict, the character development, or the turning point.
* Tags: The system can suggest tags for chapters based on the chapter's tone, style, and themes.
* Cliffhanger: This would indicate whether the chapter ends on a suspenseful note, leaving the reader wanting more.
* Twist: This would indicate whether the chapter includes a surprising plot twist or revelation.
* Flashback: This would indicate whether the chapter includes a flashback to a past event.
* Foreshadowing: This would indicate whether the chapter includes hints or clues about future events.
* Humor: This would indicate whether the chapter includes humorous elements.
* Romance: This would indicate whether the chapter includes romantic elements.
* Turning Point: This would indicate whether the chapter marks a significant turning point in the story.
* Open Questions: This would capture any unanswered questions or mysteries that are introduced in the chapter.

''';

const storyBreakdownSample = {
  "storyMetadata": {
    "title": "The Last Stand",
    "author": "John Doe",
    "goal": "To explore the struggle of survival in a post-apocalyptic world",
    "genre": ["Science Fiction", "Adventure"],
    "themes": ["Survival", "Humanity", "Courage"],
    "setting": "A dystopian future where resources are scarce",
    "wordCount": 80000,
    "creationDate": "2024-07-30",
    "storyTone": ["Gritty and intense"],
    "storyArcs": ["The protagonist's journey from despair to hope"],
    "symbolism": ["The lone tree symbolizes hope and resilience"],
    "storyStyle": ["Descriptive", "Narrative"],
    "targetAudience": ["Young Adults", "Adults"],
    "worldbuildingDetails": [
      "A world ravaged by climate change and war, with pockets of survivors struggling to rebuild"
    ],
    "storyConflicts": ["Man vs. Nature, Man vs. Man"],
    "themesAndMotifs": ["Hope, Resilience, Struggle"],
    "storyPacing": ["Fast-paced with moments of introspection"]
  },
  "characterBreakdown": [
    {
      "name": "Alex",
      "description": "A resourceful and determined survivor",
      "appearance": "Tall, with short brown hair and piercing blue eyes",
      "personality": ["Resilient", "Courageous", "Loyal"],
      "relationships": [
        {
          "type": "familial",
          "description":
              "Alex's deep bond with his sister, who he is determined to protect"
        },
        {
          "type": "romantic",
          "description": "A budding relationship with another survivor, Sam"
        }
      ],
      "backstory":
          "Grew up in a city before the collapse, learned to survive in the wild after losing his parents",
      "goals": [
        "To find a safe haven for his sister and himself",
        "To rebuild some semblance of a normal life"
      ]
    }
  ],
  "chapterBreakdown": [
    {
      "number": 1,
      "title": "The Journey Begins",
      "summary":
          "Alex and his sister set out on their journey after finding the map",
      "keyElements":
          "Departure, first obstacles, bonding moments between siblings",
      "tags": ["Introduction", "Adventure", "Family"]
    }
  ],
  "plotBreakdown": {
    "incitingIncident": "The discovery of a map leading to a rumored safe zone",
    "risingAction":
        "The journey through treacherous terrain and encounters with hostile survivors",
    "climax": "The final battle to reach the safe zone",
    "fallingAction": "The aftermath of the battle and the sacrifices made",
    "resolution": "Settling into the safe zone and starting to rebuild"
  },
  "settingBreakdown": {
    "locations": "Ruined cities, dense forests, abandoned military bases",
    "culturalElements":
        "Remnants of past cultures, new societal structures among survivors"
  },
};
