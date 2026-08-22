import { Story } from 'inkjs';

class StoryEngine {
  constructor(storyJson) {
    this.story = new Story(storyJson);
    this.pending = null;
  }

  // Reads the stat variables if the scenario declares them. Scenarios that
  // don't (scenario 1) return null and the stat bar stays hidden.
  readStats() {
    const standing = this.story.variablesState['standing'];
    const composure = this.story.variablesState['composure'];
    if (standing === undefined || composure === undefined) return null;
    return { standing, composure };
  }

  // Idempotent between choices: asking twice returns the same batch rather than
  // consuming more of the story. StrictMode mounts the renderer twice in dev and
  // both mounts call this on the same engine — without the cache the first mount
  // ate the whole opening batch and the visible one got nothing, so the scene
  // jumped straight to the choices.
  continueStory() {
    if (this.pending) return this.pending;

    const lines = [];
    while (this.story.canContinue) {
      const text = this.story.Continue();
      const tags = this.story.currentTags;
      // Snapshot the stats per line, not per batch. Ink runs every ~ statement
      // in the batch up front, so without this the numbers would move before
      // the line that caused them was on screen.
      lines.push({ text: text.trim(), tags, stats: this.readStats() });
    }

    const choices = this.story.currentChoices.map((choice, index) => ({
      index,
      text: choice.text,
    }));
    const isEnded = !this.story.canContinue && choices.length === 0;

    this.pending = { lines, choices, isEnded };
    return this.pending;
  }

  choose(index) {
    this.pending = null;
    this.story.ChooseChoiceIndex(index);
  }

  restart() {
    this.pending = null;
    this.story.ResetState();
  }
}

export default StoryEngine;