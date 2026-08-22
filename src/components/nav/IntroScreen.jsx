import { useState } from 'react';

// Title card. Pauline's artwork, with START and ABOUT laid over the empty band
// she left at the bottom of it.
//
// The buttons are positioned against the artwork rather than the window, so
// they stay in that band at any aspect ratio instead of drifting onto the
// figures.

function IntroScreen({ onStart }) {
  const [showAbout, setShowAbout] = useState(false);
  const base = import.meta.env.BASE_URL;

  return (
    <div className="intro-screen">
      <div className="intro-frame">
        <img
          className="intro-art"
          src={`${base}assets/ui/title_screen.png`}
          alt="Misandrymaxxing — a Respect at UQ module"
        />

        <div className="intro-actions">
          <button className="intro-btn intro-btn-start" onClick={onStart}>
            <img src={`${base}assets/ui/start_button.png`} alt="Start" />
          </button>
          <button className="intro-btn intro-btn-about" onClick={() => setShowAbout(true)}>
            <img src={`${base}assets/ui/about_button.png`} alt="About" />
          </button>
        </div>
      </div>

      {showAbout && (
        <div className="about-overlay" role="dialog" aria-label="About this game">
          <div className="about-panel">
            <h2>About</h2>
            <p>
              You are a man at a software firm where the ordinary run of things
              goes the other way round. Five days, from your first morning to
              your performance review.
            </p>
            <p>
              Everything here is drawn from documented accounts of women working
              in male-dominated engineering. The reversal is the point.
            </p>
            <p className="about-warning">
              <strong>Content warning:</strong> workplace sexual harassment,
              including unwanted physical contact, in Thursday's chapter. That
              chapter can be skipped without leaving the story.
            </p>
            <button className="about-close" onClick={() => setShowAbout(false)}>
              Back
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

export default IntroScreen;
