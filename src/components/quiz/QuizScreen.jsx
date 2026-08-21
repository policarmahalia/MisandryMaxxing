import { useState } from 'react';
import QuizQuestion from './QuizQuestion';
import QuizResults from './QuizResults';

function QuizScreen({ quizData, onPass, onRetry }) {
  const [answers, setAnswers] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [showResults, setShowResults] = useState(false);

  function handleAnswer(selectedIndex) {
    const updated = [...answers, selectedIndex];
    setAnswers(updated);

    if (currentIndex + 1 < quizData.length) {
      setCurrentIndex(currentIndex + 1);
    } else {
      setShowResults(true);
    }
  }

  function calculateResult() {
    const correctCount = answers.filter(
      (answer, i) => answer === quizData[i].correctAnswer
    ).length;
    const percentCorrect = (correctCount / quizData.length) * 100;
    const passed = percentCorrect >= 50;
    return { correctCount, total: quizData.length, percentCorrect, passed };
  }

  if (showResults) {
    const result = calculateResult();
    return (
      <QuizResults
        result={result}
        onRetry={onRetry}
        onContinue={onPass}
      />
    );
  }

  return (
    <QuizQuestion
      question={quizData[currentIndex]}
      onAnswer={handleAnswer}
      questionNumber={currentIndex + 1}
      totalQuestions={quizData.length}
    />
  );
}

export default QuizScreen;