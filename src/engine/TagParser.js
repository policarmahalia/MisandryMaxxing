function parseTags(rawTags = []) {
  return rawTags.map((tag) => {
    const [type, ...rest] = tag.split(':');
    return { type: type.trim(), value: rest.join(':').trim() };
  });
}

export function getTagValue(parsedTags, type) {
  const found = parsedTags.find((t) => t.type === type);
  return found ? found.value : null;
}

// # ghost_choices: "option one"|"option two"
//
// Options the player can see and cannot take. inkjs has no concept of a
// disabled choice, so the text ships as a tag and the renderer draws them
// unclickable. Returns null when the line has no ghost choices.
export function getGhostChoices(parsedTags) {
  const raw = getTagValue(parsedTags, 'ghost_choices');
  if (!raw) return null;
  return raw
    .split('|')
    .map((option) => option.trim().replace(/^"|"$/g, ''))
    .filter(Boolean);
}

export default parseTags;