import { useState } from 'react';
import SceneRenderer from './components/scenario/SceneRenderer';
import QuizScreen from './components/quiz/QuizScreen';
import StoryEngine from './engine/StoryEngine';
import storyJson from '../story/compiled/scenario1.json';
import quiz1 from './components/quiz/quizBank/quiz1.json';
import './App.css';

function App() {
  const [engine] = useState(() => new StoryEngine(storyJson));
  const [screen, setScreen] = useState('scenario'); // scenario | quiz

  function handleScenarioComplete() {
    setTimeout(() => {
      setScreen('quiz');
    }, 2000);
  }
  

  function handleQuizPass() {
    console.log('Passed! Move to next scenario or menu.');
    // hook this up to your next scenario / scenario menu later
  }

  function handleQuizRetry() {
    engine.restart();
    setScreen('scenario');
  }

  return (
    <div className="app">
      {screen === 'scenario' && (
        <SceneRenderer engine={engine} onScenarioComplete={handleScenarioComplete} />
      )}
      {screen === 'quiz' && (
        <div className="fade-transition">
          <QuizScreen quizData={quiz1} onPass={handleQuizPass} onRetry={handleQuizRetry} />
        </div>
      )}
    </div>
  );
}

export default App;