import { useState, useEffect, useRef } from 'react';
import parseTags, { getTagValue } from '../../engine/TagParser';
import ChoicePrompt from './ChoicePrompt';
import StatBar from './StatBar';

const NO_DELTA = { standing: 0, composure: 0 };

function SceneRenderer({ engine, onScenarioComplete }) {
  const [stats, setStats] = useState(null);
  const [deltas, setDeltas] = useState(NO_DELTA);
  const prevStats = useRef(null);
  const deltaTimer = useRef(null);
  // Per-instance, not window.*: StrictMode mounts this twice in dev, and a
  // global here meant two playthroughs sharing one advance callback and
  // fighting over every tap.
  const advanceQueue = useRef(null);
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
        stats: line.stats,
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
      // no more lines in this batch — show choices if any, else scenario is done
      if (result.choices.length > 0) {
        setAwaitingTap(false);
        setPromptOpen(true);
      }
      if (result.isEnded) onScenarioComplete();
      return;
    }

    const line = lines[index];
    applyStats(line.stats);
    if (line.scene) setScene(line.scene);
    setSpeaker(line.speaker || null);
    setIsThought(line.isThought);
    setDialogueText(line.text);
    setPromptOpen(false);

    if (line.scene === 'sideeyeing') {
      // auto-advance after 2s, no tap needed
      setAwaitingTap(false);
      setTimeout(() => showLine(lines, index + 1, result), 2000);
    } else {
      // wait for a tap. this has to happen on the final line too, otherwise the
      // queue never runs off the end and onScenarioComplete never fires.
      setAwaitingTap(true);
      advanceQueue.current = () => showLine(lines, index + 1, result);
    }
  }

  // Shows the new totals, and flashes the change alongside them so the player
  // can see what the line just cost.
  function applyStats(next) {
    if (!next) return;

    const prev = prevStats.current;
    if (prev) {
      const change = {
        standing: next.standing - prev.standing,
        composure: next.composure - prev.composure,
      };
      if (change.standing !== 0 || change.composure !== 0) {
        setDeltas(change);
        clearTimeout(deltaTimer.current);
        deltaTimer.current = setTimeout(() => setDeltas(NO_DELTA), 1800);
      }
    }

    prevStats.current = next;
    setStats(next);
  }

  useEffect(() => () => clearTimeout(deltaTimer.current), []);

  function handleTapContinue() {
    const next = advanceQueue.current;
    if (!next) return;
    advanceQueue.current = null;
    next();
  }

  function handleChoice(choiceIndex) {
    setPromptOpen(false);
    engine.choose(choiceIndex);
    setTimeout(pullFromEngine, 200);
  }

  return (
    <div className="scene-container" onClick={awaitingTap ? handleTapContinue : undefined}>
      <img className="scene-art-fullbleed" src={`/assets/scenes/${scene}.png`} alt="scene" />

      <StatBar stats={stats} deltas={deltas} />

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