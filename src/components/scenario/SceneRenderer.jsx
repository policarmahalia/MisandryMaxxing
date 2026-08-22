import { useState, useEffect } from 'react';
import parseTags, { getTagValue } from '../../engine/TagParser';
import ChoicePrompt from './ChoicePrompt';

function SceneRenderer({ engine, onScenarioComplete }) {
  const [dialogueText, setDialogueText] = useState('');
  const [isThought, setIsThought] = useState(false);
  const [speaker, setSpeaker] = useState(null);
  const [scene, setScene] = useState('intro');
  const [choices, setChoices] = useState([]);
  const [promptOpen, setPromptOpen] = useState(false);

  useEffect(() => {
    advance();
  }, []);

  function advance() {
    const result = engine.continueStory();
    let autoAdvancing = false;

    result.lines.forEach((line) => {
      const tags = parseTags(line.tags);
      const sceneTag = getTagValue(tags, 'scene');
      const speakerTag = getTagValue(tags, 'speaker');
      const thoughtTag = tags.some((t) => t.type === 'thought');

      if (sceneTag) setScene(sceneTag);
      setSpeaker(speakerTag || null);
      setIsThought(thoughtTag);
      setDialogueText(line.text);

      if (sceneTag === 'sideeyeing') {
        autoAdvancing = true;
        setTimeout(() => advance(), 2000);
      }
    });

    if (autoAdvancing) return;

    setChoices(result.choices);
    setPromptOpen(result.choices.length > 0);

    if (result.isEnded) onScenarioComplete();
  }

  function handleChoice(index) {
    setPromptOpen(false);
    engine.choose(index);
    setTimeout(advance, 200);
  }

  return (
    <div className="scene-container">
      <img className="scene-art-fullbleed" src={`/assets/scenes/${scene}.png`} alt="scene" />

      {!promptOpen && (
        <div className={isThought ? 'thought-box' : 'dialogue-box'}>
          {speaker && <span className="speaker-name">{speaker}</span>}
          <p>{isThought ? `[${dialogueText}]` : dialogueText}</p>
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