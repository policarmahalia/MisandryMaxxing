// Compiles story/scenarios/*.ink -> story/compiled/<name>.json
//
// Uses the compiler bundled with inkjs, so nobody needs inklecate or Inky
// installed to build. Inky is still the nicest way to WRITE and playtest a
// scenario; this is just what turns it into something the app can import.
//
//   npm run compile

import { Compiler, CompilerOptions } from 'inkjs/full';
import { readFileSync, writeFileSync, readdirSync, mkdirSync } from 'fs';
import { join, basename } from 'path';

const SRC = 'story/scenarios';
const OUT = 'story/compiled';

// scenario1_first.ink -> scenario1.json, scenario3_wednesday.ink -> scenario3.json
function outputName(file) {
  const stem = basename(file, '.ink');
  const match = stem.match(/^(scenario\d+)/);
  return `${match ? match[1] : stem}.json`;
}

mkdirSync(OUT, { recursive: true });

const files = readdirSync(SRC).filter((f) => f.endsWith('.ink'));
let failed = false;

for (const file of files) {
  const target = join(OUT, outputName(file));
  const problems = [];
  // Ink reports the useful detail (line numbers, what it expected) through this
  // handler, not the thrown error. Without it every failure is just
  // "Compilation failed."
  // sourceFilename stays null: naming it makes ink demand a FileHandler for
  // INCLUDE resolution, which we don't use.
  const options = new CompilerOptions(null, [], false, (message, type) =>
    problems.push(`${type}: ${message}`)
  );

  try {
    const story = new Compiler(readFileSync(join(SRC, file), 'utf8'), options).Compile();
    writeFileSync(target, story.ToJson());
    console.log(`  ok  ${file} -> ${target}`);
  } catch (err) {
    failed = true;
    console.error(`  FAIL  ${file}`);
    for (const problem of problems) console.error(`        ${problem}`);
    if (problems.length === 0) console.error(`        ${err.message}`);
  }
}

if (failed) process.exit(1);
console.log(`\n${files.length} scenario(s) compiled.`);
