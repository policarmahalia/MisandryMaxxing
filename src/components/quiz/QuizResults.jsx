function QuizResults({ result, onRetry, onContinue }) {
  return (
    <div>
      {result.passed ? (
        <>
          <h2>You passed!</h2>
          <p>{result.correctCount} / {result.total} correct</p>
          <button onClick={onContinue}>Continue to next scenario</button>
        </>
      ) : (
        <>
          <h2>Let's revisit this one</h2>
          <p>{result.correctCount} / {result.total} correct</p>
          <button onClick={onRetry}>Replay scenario</button>
        </>
      )}
    </div>
  );
}