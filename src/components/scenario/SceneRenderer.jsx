import { useState, useEffect } from 'react';
import parseTags, { getTagValue } from '../../engine/TagParser';
import ChoicePrompt from './ChoicePrompt';

function SceneRenderer({ engine, onScenarioComplete }) {
  const [queue, setQueue] = useState([]);
  const [dialogueText, setDialogueText] = useState('');
  const [isThought, setIsThought] = useState(false);
  const [speaker, setSpeaker] = useState(null);
  const [scene, setScene] = useState('intro');
  const [choices, setChoices] = useState([]);
  const [promptOpen, setPromptOpen] = useState(false);
  const [awaitingTap, setAwaitingTap] = useState(false);

  useEffect(() => {
    pullFromEngine();
  }, []);

  // pulls a fresh batch of lines from inkjs and starts displaying them one by one
  function pullFromEngine() {
    const result = engine.continueStory();
    const parsedLines = result.lines.map((line) => {
      const tags = parseTags(line.tags);
      return {
        text: line.text,
        scene: getTagValue(tags, 'scene'),
        speaker: getTagValue(tags, 'speaker'),
        isThought: tags.some((t) => t.type === 'thought'),
      };
    });

    setQueue(parsedLines);
    setChoices(result.choices);
    showLine(parsedLines, 0, result);
  }

  
  // displays a single line from the queue at the given index
  function showLine(lines, index, result) {
  if (index >= lines.length) {
    if (result.choices.length > 0) {
      setAwaitingTap(false);
      setPromptOpen(true);
    } else if (result.isEnded) {
      console.log('SCENARIO ENDED — calling onScenarioComplete');
      onScenarioComplete();
    }
    return;
  }

  const line = lines[index];
  if (line.scene) setScene(line.scene);
  setSpeaker(line.speaker || null);
  setIsThought(line.isThought);
  setDialogueText(line.text);
  setPromptOpen(false);

  if (line.scene === 'sideeyeing') {
    setAwaitingTap(false);
    setTimeout(() => showLine(lines, index + 1, result), 2000);
  } else if (index + 1 < lines.length) {
    // more lines still queued in this batch — wait for tap
    setAwaitingTap(true);
    window.__advanceQueue = () => showLine(lines, index + 1, result);
  } else if (result.choices.length > 0) {
    // last line in batch, but choices are coming — wait for tap then show prompt
    setAwaitingTap(true);
    window.__advanceQueue = () => showLine(lines, index + 1, result);
  } else if (result.isEnded) {
    // last line in batch, no choices, story is actually done — wait for final tap then end
    setAwaitingTap(true);
    window.__advanceQueue = () => showLine(lines, index + 1, result);
  } else {
    setAwaitingTap(false);
  }
}

  function handleTapContinue() {
    if (window.__advanceQueue) {
      const next = window.__advanceQueue;
      window.__advanceQueue = null;
      next();
    }
  }

  function handleChoice(choiceIndex) {
    setPromptOpen(false);
    engine.choose(choiceIndex);
    setTimeout(pullFromEngine, 200);
  }

  return (
    <div className="scene-container" onClick={awaitingTap ? handleTapContinue : undefined}>
      <img className="scene-art-fullbleed" src={`/assets/scenes/${scene}.png`} alt="scene" />

      {!promptOpen && (
        <div className={isThought ? 'thought-box' : 'dialogue-box'}>
          {speaker && <span className="speaker-name">{speaker}</span>}
          <p>{isThought ? `[${dialogueText}]` : dialogueText}</p>
          {awaitingTap && <span className="tap-indicator">▼</span>}
        </div>
      )}

      <ChoicePrompt
        open={promptOpen}
        thought={dialogueText}
        choices={choices}
        onSelect={handleChoice}
      />
    </div>
  );
}

export default SceneRenderer;