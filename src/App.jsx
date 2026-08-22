import { useState } from 'react';
import SceneRenderer from './components/scenario/SceneRenderer';
import QuizScreen from './components/quiz/QuizScreen';
import StoryEngine from './engine/StoryEngine';
import scenario1 from '../story/compiled/scenario1.json';
import scenario3 from '../story/compiled/scenario3.json';
import scenario4 from '../story/compiled/scenario4.json';
import scenario5 from '../story/compiled/scenario5.json';
import quiz1 from './components/quiz/quizBank/quiz1.json';
import quiz3 from './components/quiz/quizBank/quiz3.json';
import quiz4 from './components/quiz/quizBank/quiz4.json';
import quiz5 from './components/quiz/quizBank/quiz5.json';
import './App.css';

// Temporary scaffolding until ScenarioMenu.jsx exists. Add a scenario here and
// it joins the running order and becomes reachable at ?scenario=N.
// Scenario 2 goes in once its ink lands.
const SCENARIOS = {
  1: { title: 'Monday', story: scenario1, quiz: quiz1 },
  3: { title: 'Wednesday', story: scenario3, quiz: quiz3 },
  4: { title: 'Thursday', story: scenario4, quiz: quiz4 },
  5: { title: 'Friday', story: scenario5, quiz: quiz5 },
};

const ORDER = [1, 3, 4, 5];

// ?scenario=4 drops you straight into that chapter, for playtesting one
// without replaying the ones before it.
function startingId() {
  const requested = new URLSearchParams(window.location.search).get('scenario');
  return SCENARIOS[requested] ? Number(requested) : ORDER[0];
}

function App() {
  const [id, setId] = useState(startingId);
  const [engine, setEngine] = useState(() => new StoryEngine(SCENARIOS[startingId()].story));
  const [screen, setScreen] = useState('scenario'); // scenario | quiz | done

  function goTo(nextId) {
    setId(nextId);
    setEngine(new StoryEngine(SCENARIOS[nextId].story));
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
            quizData={SCENARIOS[id].quiz}
            onPass={handleQuizPass}
            onRetry={handleQuizRetry}
          />
        </div>
      )}

      {screen === 'done' && (
        <div className="quiz-results">
          <h2>End of what's built</h2>
          <p className="quiz-score-detail">
            Scenario 2 isn't inked yet. Add it to SCENARIOS in App.jsx and it
            slots into the running order on its own.
          </p>
          <div className="quiz-results-actions">
            {ORDER.map((sid) => (
              <button
                key={sid}
                className="quiz-btn-secondary"
                onClick={() => goTo(sid)}
              >
                Replay {SCENARIOS[sid].title}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
