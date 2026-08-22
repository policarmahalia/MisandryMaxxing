import { useState } from 'react';

function QuizScreen({ quizData, onPass, onRetry }) {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selected, setSelected] = useState(null);
  const [answers, setAnswers] = useState([]);
  const [showResults, setShowResults] = useState(false);

  const question = quizData[currentIndex];

  function handleSelect(optionIndex) {
    if (selected !== null) return; // prevent double-click changing answer after reveal
    setSelected(optionIndex);
  }

  function handleNext() {
    const updatedAnswers = [...answers, selected];
    setAnswers(updatedAnswers);
    setSelected(null);

    if (currentIndex + 1 < quizData.length) {
      setCurrentIndex(currentIndex + 1);
    } else {
      finishQuiz(updatedAnswers);
    }
  }

  function finishQuiz(finalAnswers) {
    const correctCount = finalAnswers.filter(
      (answer, i) => answer === quizData[i].correctAnswer
    ).length;
    const percentCorrect = (correctCount / quizData.length) * 100;
    const passed = percentCorrect >= 50;
    setShowResults({ correctCount, total: quizData.length, passed });
  }

  if (showResults) {
    return (
      <div className="quiz-results">
        {showResults.passed ? (
          <>
            <h2>You passed!</h2>
            <p>{showResults.correctCount} / {showResults.total} correct</p>
            <button onClick={onPass}>Continue</button>
          </>
        ) : (
          <>
            <h2>Let's revisit this one</h2>
            <p>{showResults.correctCount} / {showResults.total} correct</p>
            <button onClick={onRetry}>Replay scenario</button>
          </>
        )}
      </div>
    );
  }

  return (
    <div className="quiz-screen">
      <p className="quiz-topic">{question.topic}</p>
      <p className="quiz-progress">Question {currentIndex + 1} of {quizData.length}</p>
      <h2 className="quiz-question-text">{question.question}</h2>

      <div className="quiz-options">
        {question.options.map((option, i) => {
          let optionClass = 'quiz-option';
          if (selected !== null) {
            if (i === question.correctAnswer) optionClass += ' correct';
            else if (i === selected) optionClass += ' incorrect';
          }
          return (
            <button
              key={i}
              className={optionClass}
              onClick={() => handleSelect(i)}
            >
              {option}
            </button>
          );
        })}
      </div>

      {selected !== null && (
        <button className="quiz-next-btn" onClick={handleNext}>
          {currentIndex + 1 < quizData.length ? 'Next' : 'See Results'}
        </button>
      )}
    </div>
  );
}

export default QuizScreen;