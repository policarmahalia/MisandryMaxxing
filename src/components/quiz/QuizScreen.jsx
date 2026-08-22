import { useState } from 'react';

const PASS_MARK = 0.5; // 50%, same bar as the original single-answer version

function QuizScreen({ quizData, onPass, onRetry }) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selected, setSelected] = useState([]);
  const [revealed, setRevealed] = useState(false);
  const [tallies, setTallies] = useState([]);
  const [results, setResults] = useState(null);

  const question = quizData[currentIndex];
  const isLast = currentIndex + 1 >= quizData.length;

  function toggle(i) {
    if (revealed) return;
    setSelected((prev) =>
      prev.includes(i) ? prev.filter((x) => x !== i) : [...prev, i]
    );
  }

  // Per-question tally. Picking a red herring cancels out an issue you named,
  // so selecting every option scores zero rather than full marks.
  function tally() {
    const caught = question.options.filter(
      (o, i) => o.isIssue && selected.includes(i)
    ).length;
    const wrong = question.options.filter(
      (o, i) => !o.isIssue && selected.includes(i)
    ).length;
    const issueCount = question.options.filter((o) => o.isIssue).length;
    return { caught, wrong, issueCount };
  }

  function handleNext() {
    const updated = [...tallies, tally()];
    setTallies(updated);

    if (!isLast) {
      setCurrentIndex(currentIndex + 1);
      setSelected([]);
      setRevealed(false);
      return;
    }

    const score =
      updated.reduce(
        (sum, t) => sum + Math.max(0, (t.caught - t.wrong) / t.issueCount),
        0
      ) / updated.length;

    setResults({
      percent: Math.round(score * 100),
      passed: score >= PASS_MARK,
      caught: updated.reduce((s, t) => s + t.caught, 0),
      wrong: updated.reduce((s, t) => s + t.wrong, 0),
      issueCount: updated.reduce((s, t) => s + t.issueCount, 0),
    });
  }

  function retryQuiz() {
    setCurrentIndex(0);
    setSelected([]);
    setRevealed(false);
    setTallies([]);
    setResults(null);
  }

  function optionClass(option, i) {
    const picked = selected.includes(i);
    if (!revealed) return picked ? 'quiz-option selected' : 'quiz-option';
    if (option.isIssue) return picked ? 'quiz-option caught' : 'quiz-option missed';
    return picked ? 'quiz-option herring' : 'quiz-option dim';
  }

  function summary() {
    const { caught, issueCount } = tally();
    const missed = issueCount - caught;
    if (caught === 0) return `${issueCount} things were happening at once here.`;
    if (missed === 0) return `You named all ${issueCount}.`;
    return `You named ${caught}. ${missed} more ${
      missed === 1 ? 'was' : 'were'
    } happening at the same time.`;
  }

  if (results) {
    return (
      <div className="quiz-results">
        {results.passed ? (
          <>
            <h2>Module complete</h2>
            <p className="quiz-score">{results.percent}%</p>
            <p className="quiz-score-detail">
              You named {results.caught} of {results.issueCount}
              {results.wrong > 0 &&
                ` — ${results.wrong} of your selections weren't the issue`}
              .
            </p>
            <button onClick={onPass}>Continue</button>
          </>
        ) : (
          <>
            <h2>Not yet complete</h2>
            <p className="quiz-score">{results.percent}%</p>
            <p className="quiz-score-detail">
              You need {Math.round(PASS_MARK * 100)}% to continue. You named{' '}
              {results.caught} of {results.issueCount}
              {results.wrong > 0 &&
                ` — ${results.wrong} of your selections weren't the issue`}
              .
            </p>
            <div className="quiz-results-actions">
              <button onClick={retryQuiz}>Retake the questions</button>
              <button className="quiz-btn-secondary" onClick={onRetry}>
                Replay the scenario
              </button>
            </div>
          </>
        )}
      </div>
    );
  }

  return (
    <div className="quiz-screen">
      <p className="quiz-topic">{question.topic}</p>
      <p className="quiz-progress">
        Question {currentIndex + 1} of {quizData.length}
      </p>
      <h2 className="quiz-question-text">{question.question}</h2>
      <p className="quiz-instruction">
        {revealed ? summary() : 'Select everything you noticed.'}
      </p>

      <div className="quiz-options">
        {question.options.map((option, i) => (
          <div key={i} className="quiz-option-row">
            <button
              type="button"
              className={optionClass(option, i)}
              aria-pressed={selected.includes(i)}
              disabled={revealed}
              onClick={() => toggle(i)}
            >
              {option.text}
            </button>
            {revealed && option.note && <p className="quiz-note">{option.note}</p>}
          </div>
        ))}
      </div>

      {revealed ? (
        <button className="quiz-next-btn" onClick={handleNext}>
          {isLast ? 'See results' : 'Next'}
        </button>
      ) : (
        <button className="quiz-next-btn" onClick={() => setRevealed(true)}>
          Show what was happening
        </button>
      )}
    </div>
  );
}

export default QuizScreen;
