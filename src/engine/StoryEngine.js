import { Story } from 'inkjs';

class StoryEngine {
  constructor(storyJson, carriedState) {
    this.story = new Story(storyJson);
    this.pending = null;
    if (carriedState) this.importState(carriedState);
  }

  // Values that follow the player from one chapter to the next. Anything not
  // listed here resets, which is what you want for scene-local flags.
  static CARRIED = [
    'standing',
    'composure',
    'kept_receipts',   // Wed -> Thu, where it pays off by not helping
    'named_it',        // Thu -> Fri, changes how Delia's reveal reads
    'reported',        // Thu -> Fri, the outcome letter lands mid-review
    'deflected',       // Thu -> Fri, "you're easy to have around"
    'note_taker',      // Tue -> Fri, one line about not driving the room
    'froze',
    'left_room',
  ];

  // Reads the carried values off this scenario's final state.
  exportState() {
    const out = {};
    for (const name of StoryEngine.CARRIED) {
      const value = this.story.variablesState[name];
      if (value !== null && value !== undefined) out[name] = value;
    }
    return out;
  }

  // Writes them into the next scenario, skipping any it doesn't declare.
  importState(carried) {
    for (const [name, value] of Object.entries(carried)) {
      // inkjs returns null for a variable the story doesn't declare, and
      // assigning to one throws "Cannot assign to a variable that hasn't been
      // declared". Skip anything this scenario doesn't know about.
      if (this.story.variablesState[name] !== null &&
          this.story.variablesState[name] !== undefined) {
        this.story.variablesState[name] = value;
      }
    }
  }

  // Reads the stat variables if the scenario declares them. Scenarios that
  // don't (scenario 1) return null and the stat bar stays hidden.
  readStats() {
    const standing = this.story.variablesState['standing'];
    const composure = this.story.variablesState['composure'];
    if (standing === null || standing === undefined) return null;
    if (composure === null || composure === undefined) return null;
    return { standing, composure };
  }

  // Idempotent between choices: asking twice returns the same batch rather than
  // consuming more of the story. StrictMode mounts the renderer twice in dev and
  // both mounts call this on the same engine — without the cache the first mount
  // ate the whole opening batch and the visible one got nothing, so the scene
  // jumped straight to the choices.
  // Snapshot of the story right now, for the back button. Cheap enough to take
  // one per batch.
  saveState() {
    return this.story.state.toJson();
  }

  restoreState(json) {
    this.story.state.LoadJson(json);
    this.pending = null;
  }

  continueStory() {
    if (this.pending) return this.pending;

    // Captured before the batch is consumed, so restoring it and calling
    // continueStory again replays exactly this batch.
    const batchState = this.saveState();
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

    this.pending = { lines, choices, isEnded, batchState };
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