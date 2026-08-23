import { useState, useEffect, useRef } from 'react';
import parseTags, { getTagValue, getGhostChoices } from '../../engine/TagParser';
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
  const [ghostChoices, setGhostChoices] = useState(null);
  // Visited positions, for the back button: one entry per line shown, holding
  // the ink snapshot for its batch plus the index within it. Restoring means
  // reloading that snapshot and replaying the batch to the same line, so going
  // back across a choice genuinely un-makes it.
  const history = useRef([]);
  const [canGoBack, setCanGoBack] = useState(false);
  // auto-advance timers (ghost choices, sideeyeing) — cleared on rewind so a
  // pending tick can't fire into a restored position
  const autoTimer = useRef(null);

  useEffect(() => {
    pullFromEngine();
  }, []);

  function parseBatch(result) {
    return result.lines.map((line) => {
      const tags = parseTags(line.tags);
      return {
        text: line.text,
        stats: line.stats,
        // `background` is scenario 3's tag for the same thing. `character` is
        // parsed but not rendered yet — it assumes a sprite layered over a
        // background, and the current art is single composite scenes.
        scene: getTagValue(tags, 'scene') || getTagValue(tags, 'background'),
        character: getTagValue(tags, 'character'),
        speaker: getTagValue(tags, 'speaker'),
        ghostChoices: getGhostChoices(tags),
        isThought: tags.some((t) => t.type === 'thought'),
        isFlash: tags.some((t) => t.type === 'flash'),
        // A flash-cut writes several # background tags with no text between
        // them, so ink hands them over as one line carrying all of them.
        flashFrames: tags
          .filter((t) => t.type === 'background' || t.type === 'scene')
          .map((t) => t.value),
      };
    });
  }

  // pulls a fresh batch of lines from inkjs and starts displaying them one by one
  function pullFromEngine() {
    const result = engine.continueStory();
    const parsedLines = parseBatch(result);
    setQueue(parsedLines);
    setChoices(result.choices);
    showLine(parsedLines, 0, result);
  }

  // Left arrow. Drops the current position and restores the one before it.
  function goBack() {
    if (history.current.length < 2) return;
    clearTimeout(autoTimer.current);

    history.current.pop();
    const prev = history.current[history.current.length - 1];

    engine.restoreState(prev.batchState);
    const result = engine.continueStory();
    const parsedLines = parseBatch(result);

    setQueue(parsedLines);
    setChoices(result.choices);
    // no delta flash on a rewind — the numbers are going backwards
    prevStats.current = null;
    setDeltas(NO_DELTA);
    showLine(parsedLines, prev.index, result, true);
  }

  useEffect(() => {
    function onKey(e) {
      if (e.key === 'ArrowLeft') {
        e.preventDefault();
        goBack();
      }
    }
    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  });

  
  // displays a single line from the queue at the given index
  function showLine(lines, index, result, restoring = false) {
    if (index >= lines.length) {
      if (result.choices.length > 0) {
        setAwaitingTap(false);
        setPromptOpen(true);
      } else if (result.isEnded) {
        onScenarioComplete();
      }
      return;
    }

    const line = lines[index];

    if (restoring) {
      // trim anything the rewind invalidated, then re-record this position
      history.current = history.current.slice(0, -1);
    }

    // StrictMode re-runs the mount effect on the same instance, so refs
    // survive and the opening line would otherwise be recorded twice — which
    // showed a back affordance on the very first line of a scenario.
    const top = history.current[history.current.length - 1];
    if (!top || top.batchState !== result.batchState || top.index !== index) {
      history.current.push({ batchState: result.batchState, index });
    }
    setCanGoBack(history.current.length > 1);

    applyStats(line.stats);
    if (line.scene) setScene(line.scene);
    setSpeaker(line.speaker || null);
    setIsThought(line.isThought);
    setDialogueText(line.text);
    setPromptOpen(false);
    setGhostChoices(line.ghostChoices || null);

    if (line.ghostChoices) {
      // Options he can see and cannot take. No tap — the scene moves on
      // without him, which is the point.
      setAwaitingTap(false);
      autoTimer.current = setTimeout(() => showLine(lines, index + 1, result), 4000);
    } else if (line.scene === 'sideeyeing') {
      setAwaitingTap(false);
      autoTimer.current = setTimeout(() => showLine(lines, index + 1, result), 2000);
    } else if (line.isFlash) {
      // Rapid cut, no tap, 0.5s a frame. Ink emits no line for a tag-only
      // block, so the whole flash arrives as one line carrying every
      // background — step through them all rather than showing the first.
      setAwaitingTap(false);
      const frames = line.flashFrames.length ? line.flashFrames : [line.scene];
      let f = 0;
      const tick = () => {
        setScene(frames[f]);
        f += 1;
        autoTimer.current = setTimeout(
          f < frames.length ? tick : () => showLine(lines, index + 1, result),
          500
        );
      };
      tick();
    } else if (index + 1 < lines.length) {
      // more lines still queued in this batch — wait for tap
      setAwaitingTap(true);
      advanceQueue.current = () => showLine(lines, index + 1, result);
    } else if (result.choices.length > 0) {
      // last line in batch, but choices are coming — wait for tap then prompt
      setAwaitingTap(true);
      advanceQueue.current = () => showLine(lines, index + 1, result);
    } else if (result.isEnded) {
      // last line in batch, story is done — wait for a final tap then end
      setAwaitingTap(true);
      advanceQueue.current = () => showLine(lines, index + 1, result);
    } else {
      setAwaitingTap(false);
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

  useEffect(() => () => {
    clearTimeout(deltaTimer.current);
    clearTimeout(autoTimer.current);
  }, []);

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
      <img
        className="scene-art-fullbleed"
        src={`${import.meta.env.BASE_URL}assets/scenes/${scene}.png`}
        alt=""
        onError={(e) => { e.target.style.visibility = 'hidden'; }}
        onLoad={(e) => { e.target.style.visibility = 'visible'; }}
      />

      <StatBar stats={stats} deltas={deltas} />

      {canGoBack && (
        <button
          className="back-hint"
          onClick={(e) => { e.stopPropagation(); goBack(); }}
          aria-label="Go back one step"
        >
          &larr; back
        </button>
      )}

      {ghostChoices && (
        <div className="ghost-choices" aria-hidden="true">
          {ghostChoices.map((option, i) => (
            <button key={i} className="choice-prompt-btn ghost" disabled tabIndex={-1}>
              {option}
            </button>
          ))}
        </div>
      )}

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
        isThought={isThought}
        choices={choices}
        onSelect={handleChoice}
      />
    </div>
  );
}

export default SceneRenderer;