// Title card. Click anywhere, or press enter/space, to start scenario 1.

function IntroScreen({ onStart }) {
  return (
    <button className="intro-screen" onClick={onStart} aria-label="Start the game">
      <span className="intro-welcome">welcome to</span>
      <span className="intro-title">misandry maxxing</span>
      <span className="intro-tagline">walk a mile in these Louboutins</span>
      <span className="intro-hint">click anywhere to begin</span>
    </button>
  );
}

export default IntroScreen;
