function ChoicePrompt({ open, thought, isThought = true, choices, onSelect }) {
  return (
    <div className={`choice-prompt ${open ? 'open' : ''}`}>
      <p className={`choice-prompt-thought ${isThought ? '' : 'plain'}`}>
        {isThought ? `[${thought}]` : thought}
      </p>
      <div className="choice-prompt-options">
        {choices.map((choice) => (
          <button
            key={choice.index}
            className="choice-prompt-btn"
            onClick={() => onSelect(choice.index)}
          >
            {choice.text}
          </button>
        ))}
      </div>
    </div>
  );
}

export default ChoicePrompt;
