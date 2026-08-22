import { useState } from 'react';
import SceneRenderer from './components/scenario/SceneRenderer';
import QuizScreen from './components/quiz/QuizScreen';
import StoryEngine from './engine/StoryEngine';
import scenarioMeta from './data/scenarioMeta';
import scenario1 from '../story/compiled/scenario1.json';
import scenario2 from '../story/compiled/scenario2.json';
import scenario3 from '../story/compiled/scenario3.json';
import scenario4 from '../story/compiled/scenario4.json';
import scenario5 from '../story/compiled/scenario5.json';
import quiz1 from './components/quiz/quizBank/quiz1.json';
import quiz2 from './components/quiz/quizBank/quiz2.json';
import quiz3 from './components/quiz/quizBank/quiz3.json';
import quiz4 from './components/quiz/quizBank/quiz4.json';
import quiz5 from './components/quiz/quizBank/quiz5.json';
import './App.css';

// scenarioMeta drives the order and titles; these map its ink/quiz keys to the
// actual imported JSON. Vite needs static imports, so both lists move together.
const STORIES = { scenario1, scenario2, scenario3, scenario4, scenario5 };
const QUIZZES = { quiz1, quiz2, quiz3, quiz4, quiz5 };

const ORDER = scenarioMeta.map((s) => s.id);

function metaFor(id) {
  return scenarioMeta.find((s) => s.id === id);
}

// ?scenario=4 drops you straight into that chapter, for playtesting one
// without replaying the ones before it.
function startingId() {
  const requested = Number(new URLSearchParams(window.location.search).get('scenario'));
  return metaFor(requested) ? requested : ORDER[0];
}

function App() {
  const [id, setId] = useState(startingId);
  const [engine, setEngine] = useState(
    () => new StoryEngine(STORIES[metaFor(startingId()).ink])
  );
  const [screen, setScreen] = useState('scenario'); // scenario | quiz | done

  const meta = metaFor(id);

  // Standing, composure and the cross-chapter flags follow the player forward.
  // Without this every chapter restarted at 0 and Friday's ending was decided
  // by Friday alone.
  function goTo(nextId) {
    const carried = engine.exportState();
    setId(nextId);
    setEngine(new StoryEngine(STORIES[metaFor(nextId).ink], carried));
    setScreen('scenario');
  }

  function handleScenarioComplete() {
    setTimeout(() => setScreen('quiz'), 2000);
  }

  function handleQuizPass() {
    const next = ORDER[ORDER.indexOf(id) + 1];
    if (next === undefined) {
      setScreen('done');
      return;
    }
    goTo(next);
  }

  function handleQuizRetry() {
    engine.restart();
    setScreen('scenario');
  }

  return (
    <div className="app">
      {screen === 'scenario' && (
        // key remounts the renderer on scenario change so it pulls from the
        // new engine instead of sitting on the previous batch.
        <SceneRenderer
          key={id}
          engine={engine}
          onScenarioComplete={handleScenarioComplete}
        />
      )}

      {screen === 'quiz' && (
        <div className="fade-transition">
          <QuizScreen
            key={id}
            quizData={QUIZZES[meta.quiz]}
            onPass={handleQuizPass}
            onRetry={handleQuizRetry}
          />
        </div>
      )}

      {screen === 'done' && (
        <div className="quiz-results">
          <h2>The end</h2>
          <p className="quiz-score-detail">
            That's all five. Pick one to replay.
          </p>
          <div className="quiz-results-actions">
            {scenarioMeta.map((s) => (
              <button key={s.id} className="quiz-btn-secondary" onClick={() => goTo(s.id)}>
                {s.title}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
