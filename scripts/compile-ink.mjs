// Compiles story/scenarios/*.ink -> story/compiled/<name>.json
//
// Uses the compiler bundled with inkjs, so nobody needs inklecate or Inky
// installed to build. Inky is still the nicest way to WRITE and playtest a
// scenario; this is just what turns it into something the app can import.
//
//   npm run compile

import { Compiler } from 'inkjs/full';
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
  try {
    const story = new Compiler(readFileSync(join(SRC, file), 'utf8')).Compile();
    writeFileSync(target, story.ToJson());
    console.log(`  ok  ${file} -> ${target}`);
  } catch (err) {
    failed = true;
    console.error(`  FAIL  ${file}`);
    console.error(`        ${err.message}`);
  }
}

if (failed) process.exit(1);
console.log(`\n${files.length} scenario(s) compiled.`);
