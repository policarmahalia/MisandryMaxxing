import { useState } from 'react';
import SceneRenderer from './components/scenario/SceneRenderer';
import StoryEngine from './engine/StoryEngine';
import storyJson from '../story/compiled/scenario1.json';
import './App.css';

function App() {
  const [engine] = useState(() => new StoryEngine(storyJson));

  return (
    <div className="app">
      <SceneRenderer
        engine={engine}
        onScenarioComplete={() => console.log('Scenario complete!')}
      />
    </div>
  );
}

export default App;