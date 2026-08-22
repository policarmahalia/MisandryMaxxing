# Art needed

For Pauleen. Every entry says what it is **and where it appears**, so the mood
of the scene is on the page next to the request.

**Spec:** 1951 × 1100 PNG, matching the existing set — line-art characters over
a desaturated open-plan office photo.

**Filenames must be lowercase and match the tag exactly.** macOS won't complain
if the case is wrong but Vite and GitHub Pages both will. That's what caused the
broken images in scenario 1.

---

## Decision needed before anything gets drawn

The two scenarios use different systems, and someone has to pick one.

**Scenario 1** tags whole composites — `# scene: judgemental` loads one finished
picture with the character already in it. That's what the eight existing files are.

**Scenario 3** tags a background and a character separately:

```
# background: meeting_room
# character: linda, neutral, centre
```

That assumes a sprite drawn on transparency, positioned over a background.

It matters because of what each costs. Scenario 3 has **5 backgrounds and 6
character states**. Layered, that's **11 drawings**. As composites, it's every
background × every character who appears in it — **around 20**, and every new
line of dialogue in an existing room risks another one.

Layering is fewer drawings and far more reusable, but it means Pauleen draws
characters cut out rather than in scene, and the existing eight would eventually
want redoing to match. **Recommend layering, and taking the hit on the existing
eight later** — but it's her call, since she's drawing it.

Until that's settled the renderer treats `background` as a composite lookup, so
scenario 3 runs today with whatever is in the folder and falls back to black.

---

## Scenario 3 — Wednesday

### Backgrounds

| Tag | Where it's used | Feel |
|---|---|---|
| `openplan_morning` | **12 lines.** The whole report scene — he finalises it at 10:40, Delia arrives at 11:15, and all four responses play here. Also the shared-drive moment afterwards. | Ordinary Wednesday. Nothing has visibly gone wrong. The scene's weight is entirely in the dialogue, so the room should stay flat and unremarkable. |
| `slack_ui` | **10 lines.** The #platform-eng thread that resolves without him, then the Jean DM exchange. | A chat interface. His message needs to be visibly *there* with nothing under it — the gap is the point. |
| `meeting_room` | **9 lines.** The five-o'clock sync: the minutes, the ghost-choice beat, Chesca's question, his presentation. | The chapter's only real choice point and its hardest four seconds. Several colleagues seated, table, laptops. Tense but not dramatic. |
| `kitchenette` | **6 lines.** The Sarah conversation (only if the player asked for it) and Kiera's "you clean up so well". | Warm and completely unthreatening. Both scenes here are people being nice to him. |
| `home_evening` | **6 lines.** 21:40, opening the PR. Then next morning: forty-one comments against Chesca's LGTM. | Away from the office, alone, late. The only room in the chapter that's his. |

### Characters

| Tag | Where it's used | Notes |
|---|---|---|
| `sarah, warm, left` | **6 lines.** Her whole scene — she's apologising and means it. | Genuinely pleased to see him. She is not a villain and must not look like one. |
| `linda, neutral, centre` | **6 lines.** Runs the sync, asks for minutes, hands the fix to Chesca. | Efficient, pleasant, not unkind. Reads as someone with a meeting to get through. |
| `boss, tired, right` | **5 lines.** Delia at his desk with the wrong report. | **Tired, not furious.** She doesn't have time to adjudicate. If she reads as angry the whole scene collapses into a villain story. |
| `boss, cool, right` | **2 lines.** Only on the "Sarah must have overwritten it" route. | A single degree cooler than `tired`. The difference should be barely perceptible — that's what makes it land. |
| `kiera, cheerful, right` | **2 lines.** The kitchenette compliment. | She means it warmly. Same Kiera as scenario 1. |
| `chesca, neutral, left` | **1 line.** Asks his question back to the room and gets thanked for it. | Onscreen briefly and does nothing wrong. Deliberately not Sarah — using one woman for both makes it a vendetta instead of a pattern. |

### Priority if time runs short

1. `openplan_morning` and `meeting_room` — between them they carry the report scene and the sync, which is most of the chapter.
2. `kitchenette` — two scenes.
3. `slack_ui` — could be a flat mocked-up UI rather than a drawing, and would still work.
4. `home_evening` — the coda. Lowest cost if it falls back to black.

---

## Scenario 4 — Thursday

Content warning scenario. Reuses `home_evening`, `openplan_morning` and
`kitchenette` from Wednesday. Three new backgrounds, two new characters.

### Backgrounds

| Tag | Where it's used | Feel |
|---|---|---|
| `black` | The content warning card, and the skip summary. | Not a drawing — a flat black field the warning text sits on. Can be pure CSS if that's easier. |
| `meeting_room_night` | **The whole harassment sequence**, both scenes and all eight responses. | 19:50, floor empty, door pushed shut, corridor light on a sensor flicking on and off. It should look like an ordinary meeting room after hours, because it is one. **Nothing menacing in the staging** — the register note is "nobody leers, including the prose", and that goes for the art. |
| `small_room` | The People and Culture conversation, all three outcomes. | A small booked room. Robyn is kind and the room should be too. The failure here is procedural, not personal, and the picture shouldn't telegraph it. |

### Characters

| Tag | Where it's used | Notes |
|---|---|---|
| `dani, relaxed, right` | Most of her lines — the opener, and the exit line afterwards. | Principal engineer, two levels up. Comfortable, friendly, entirely at ease. She is not written as a predator and must not be drawn as one; the discomfort is meant to come from the words. |
| `dani, close, right` | The hand scene only. | Same character, closer to frame. **The change should be spatial, not expressive** — she looks exactly as friendly as before. That's the whole point of the scene. |
| `robyn, kind, centre` | Her scene. | People and Culture. Genuinely kind, listens to the end, and cannot help. Warm, unhurried, mid-forties reading. |

### Priority

`meeting_room_night` is the one that matters — it carries the chapter's two
hardest scenes and both Dani states. `black` needs no drawing. `small_room`
could fall back to `meeting_room` at a pinch.

---

## Scenario 1 — Monday

Already drawn: `intro` · `surprised` · `shocked` · `sideeyeing` · `checking` ·
`pointing` · `judgemental`

Each is used once. `sideeyeing` holds for a scripted two seconds with no tap,
so it gets looked at longer than the others.

`listening` is drawn but **not used by any scenario yet** — worth a look before
new work starts, it may already cover something scenario 3 needs.

---

## If the art isn't ready

Missing files fall back to black and the text still plays, so **nothing here
blocks writing scenarios 2, 4 and 5**. Tags can point at whatever exists and be
swapped later with a find-and-replace.
