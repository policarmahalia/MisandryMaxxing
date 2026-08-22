// The running order. Add a scenario here and it joins the chain and becomes
// reachable at ?scenario=<id>. The ink/quiz strings are the keys App.jsx uses
// to look up the imported JSON.
const scenarioMeta = [
  { id: 1, title: 'The Meeting',     ink: 'scenario1', quiz: 'quiz1' },
  { id: 2, title: 'The Note Taker',  ink: 'scenario2', quiz: 'quiz2' },
  { id: 3, title: 'Version History', ink: 'scenario3', quiz: 'quiz3' },
  { id: 4, title: 'Informally',      ink: 'scenario4', quiz: 'quiz4' },
  { id: 5, title: 'Calibration',     ink: 'scenario5', quiz: 'quiz5' },
];

export default scenarioMeta;
