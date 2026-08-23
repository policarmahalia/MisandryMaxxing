// The running order. Add a scenario here and it joins the chain and becomes
// reachable at ?scenario=<id>. Remove it and it becomes unreachable without
// deleting anything.
//
// Scenario 5 (Friday, "Calibration") is CUT FOR TIME, not deleted. Its ink,
// compiled JSON, quiz and SCENARIO5_BRIEF.md are all still in the repo. To put
// it back: uncomment the line below, and re-add scenario5/quiz5 to the imports
// and lookup maps in App.jsx.
const scenarioMeta = [
  { id: 1, title: 'The Meeting',     ink: 'scenario1', quiz: 'quiz1' },
  { id: 2, title: 'The Note Taker',  ink: 'scenario2', quiz: 'quiz2' },
  { id: 3, title: 'Version History', ink: 'scenario3', quiz: 'quiz3' },
  { id: 4, title: 'Informally',      ink: 'scenario4', quiz: 'quiz4' },
  // { id: 5, title: 'Calibration',  ink: 'scenario5', quiz: 'quiz5' },
];

export default scenarioMeta;
