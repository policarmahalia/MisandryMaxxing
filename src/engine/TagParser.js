function parseTags(rawTags = []) {
  return rawTags.map((tag) => {
    const [type, ...rest] = tag.split(':');
    return {
      type: type.trim(),
      value: rest.join(':').trim(),
    };
  });
}

export function getTagValue(parsedTags, type) {
  const found = parsedTags.find((t) => t.type === type);
  return found ? found.value : null;
}

export default parseTags;