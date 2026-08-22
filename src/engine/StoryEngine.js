import { Story } from 'inkjs';

class StoryEngine {
  constructor(storyJson) {
    this.story = new Story(storyJson);
  }

  continueStory() {
    const lines = [];
    while (this.story.canContinue) {
      const text = this.story.Continue();
      const tags = this.story.currentTags;
      lines.push({ text: text.trim(), tags });
    }

    const choices = this.story.currentChoices.map((choice, index) => ({
      index,
      text: choice.text,
    }));


    const isEnded = !this.story.canContinue && choices.length === 0;

    return { lines, choices, isEnded };
  }

  choose(index) {
    this.story.ChooseChoiceIndex(index);
  }

  restart() {
    this.story.ResetState();
  }
}

export default StoryEngine;