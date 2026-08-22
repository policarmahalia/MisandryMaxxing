import { useState, useEffect } from 'react';
import SceneRenderer from './components/scenario/SceneRenderer';
import QuizScreen from './components/quiz/QuizScreen';
import StoryEngine from './engine/StoryEngine';
import scenarioMeta from './data/scenarioMeta';
import './App.css';

function App() {
  const [scenarioIndex, setScenarioIndex] = useState(0);
  const [screen, setScreen] = useState('scenario'); // scenario | quiz
  const [engine, setEngine] = useState(null);
  const [quizData, setQuizData] = useState(null);

  const currentMeta = scenarioMeta[scenarioIndex];

  useEffect(() => {
    async function loadScenario() {
      const storyModule = await import(`../story/compiled/${currentMeta.ink}.json`);
      setEngine(new StoryEngine(storyModule.default));

      const quizModule = await import(`./components/quiz/quizBank/${currentMeta.quiz}.json`);
      setQuizData(quizModule.default);

      setScreen('scenario');
    }
    loadScenario();
  }, [scenarioIndex]);

  function handleScenarioComplete() {
    setTimeout(() => {
      setScreen('quiz');
    }, 2000);
  }

  function handleQuizPass() {
    if (scenarioIndex + 1 < scenarioMeta.length) {
      setScenarioIndex(scenarioIndex + 1);
    } else {
      console.log('All scenarios complete!');
    }
  }

  function handleQuizRetry() {
    engine.restart();
    setScreen('scenario');
  }

  if (!engine || !quizData) {
    return <div className="app-loading">Loading...</div>;
  }

  return (
    <div className="app">
      {screen === 'scenario' && (
        <SceneRenderer
          key={currentMeta.id}
          engine={engine}
          onScenarioComplete={handleScenarioComplete}
        />
      )}
      {screen === 'quiz' && (
        <div className="fade-transition">
          <QuizScreen quizData={quizData} onPass={handleQuizPass} onRetry={handleQuizRetry} />
        </div>
      )}
    </div>
  );
}

export default App;