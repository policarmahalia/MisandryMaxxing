import { useState } from 'react';

// Three-beat opening: closed laptop -> open laptop -> the onboarding email,
// each on tap, with a short internal-monologue caption under each. Ends by
// calling onComplete, which App.jsx wires to the first scenario.

const BEATS = [
  {
    image: 'closed_laptop',
    caption: "First day. I can't believe I actually got this job.",
  },
  {
    image: 'open_laptop',
    caption: "Okay. Let's see what we're working with.",
  },
  {
    image: 'onboarding_email',
    caption: 'An onboarding email already. This is really happening.',
    zoom: true,
  },
];

function PrologueScene({ onComplete }) {
  const [step, setStep] = useState(0);
  const base = import.meta.env.BASE_URL;
  const beat = BEATS[step];

  function handleTap() {
    if (step + 1 < BEATS.length) {
      setStep(step + 1);
    } else {
      onComplete();
    }
  }

  return (
    <div className="prologue-scene" onClick={handleTap}>
      <img
        key={beat.image}
        className={`prologue-art ${beat.zoom ? 'prologue-art-zoom' : ''}`}
        src={`${base}assets/ui/${beat.image}.png`}
        alt=""
        onError={() => console.error(`Missing prologue asset: ${beat.image}.png`)}
      />

      <div className="thought-box prologue-caption">
        <p>[{beat.caption}]</p>
        <span className="tap-indicator">▼</span>
      </div>
    </div>
  );
}

export default PrologueScene;