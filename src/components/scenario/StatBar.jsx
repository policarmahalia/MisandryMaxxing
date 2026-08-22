// Small persistent readout of the two axes. Hidden entirely for scenarios that
// don't declare the variables, so scenario 1 is unaffected.

function Stat({ label, value, delta }) {
  return (
    <div className="stat">
      <span className="stat-label">{label}</span>
      <span className="stat-value">{value > 0 ? `+${value}` : value}</span>
      {delta !== 0 && (
        <span className={`stat-delta ${delta > 0 ? 'up' : 'down'}`}>
          {delta > 0 ? `+${delta}` : delta}
        </span>
      )}
    </div>
  );
}

function StatBar({ stats, deltas }) {
  if (!stats) return null;

  return (
    <div className="stat-bar" aria-live="polite">
      <Stat label="Standing" value={stats.standing} delta={deltas.standing} />
      <Stat label="Composure" value={stats.composure} delta={deltas.composure} />
    </div>
  );
}

export default StatBar;
