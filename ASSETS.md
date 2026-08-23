# Art needed

For Sarah. Every entry says what it is **and where it appears**, so the mood
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

Layering is fewer drawings and far more reusable, but it means the artist draws
characters cut out rather than in scene, and the existing eight would eventually
want redoing to match. **Recommend layering, and taking the hit on the existing
eight later** — but it's her call, since she's drawing it.

Until that's settled the renderer treats `background` as a composite lookup, so
scenario 3 runs today with whatever is in the folder and falls back to black.

---

## Scenario 2 — The Note Taker

All six backgrounds are drawn: `intro_ignoring` · `staring` · `awkward` ·
`callout` · `laughing` · `meme`. **Nothing new needed.**

One note: the **ghost-choice beat** now lives here, during Linda's
presentation — two options rendered greyed and unclickable for four seconds
while his hands are on the keyboard. It reuses `staring` and `intro_ignoring`,
so it costs no new art, but it is the most important four seconds in the
chapter and the art should not distract from it.

---

## Scenario 3 — Wednesday

### Backgrounds

| Tag | Where it's used | Feel |
|---|---|---|
| `boss_intro` / `boss_scolding` / `boss_showing` | **17 lines.** The whole report scene — DRAWN. | Delia at a desk with a laptop, three states. |
| `openplan_morning` | **no longer used by Wednesday.** The whole report scene — he finalises it at 10:40, Delia arrives at 11:15, and all four responses play here. Also the shared-drive moment afterwards. | Ordinary Wednesday. Nothing has visibly gone wrong. The scene's weight is entirely in the dialogue, so the room should stay flat and unremarkable. |
| `slack_ui` | **10 lines.** The #platform-eng thread that resolves without him, then the Jean DM exchange. | A chat interface. His message needs to be visibly *there* with nothing under it — the gap is the point. |
| `home_evening` | **6 lines.** 21:40, opening the PR. Then next morning: forty-one comments against Ellie's LGTM. | Away from the office, alone, late. The only room in the chapter that's his. |

### Characters

| Tag | Where it's used | Notes |
|---|---|---|
| `delia, tired, right` | **5 lines.** Delia at his desk with the wrong report. | **Tired, not furious.** She doesn't have time to adjudicate. If she reads as angry the whole scene collapses into a villain story. |
| `delia, cool, right` | **2 lines.** Only on the "Sarah must have overwritten it" route. | A single degree cooler than `tired`. The difference should be barely perceptible — that's what makes it land. |

### Priority if time runs short

1. `openplan_morning` — carries the entire report scene and all four responses, which is most of the chapter.
2. `slack_ui` — could be a flat mocked-up UI rather than a drawing, and would still work.
3. `home_evening` — the coda, and shared with Thursday.

---

## Scenario 4 — Thursday

Rewritten. **Ten new backgrounds, none of them drawn** — this chapter currently
plays entirely on black, so it's the biggest art gap in the game.

| Tag | Where it's used | Feel |
|---|---|---|
| `office_close` | Opening. Kept back after hours for a "quick performance check". | An office after everyone's gone. Ordinary, not sinister — the staging should not telegraph anything. |
| `boss_pleased` | "I'm impressed with your performance." | Warm, complimentary. She means it, and that's what makes the next beat work. |
| `boss_smirk` | "Are you somebody's nephew? Or… did you sleep with someone?" | The turn. Still friendly on the surface. |
| `boss_laugh` | "Relax. I'm just asking." | Laughing it off, putting it back on him for reacting. |
| `boss_tie` | Standing in front of him, playing with his tie. "I can make things very easy for you here. Or very hard." | First physical contact. **Close, not lurid** — the discomfort should come from the words and the proximity. |
| `boss_pull` | Her hand slides down his arm. | |
| `boss_grip` | "Or maybe you want to make things really easy for yourself." | |
| `boss_release` | She lets go, smirking. "I'll see you Monday then. Same time." | The scene ends with her entirely unbothered. |
| `bed_dark` | That night, awake, still working it out. | Alone, dark, no resolution. |
| `blackout` | The two closing lines. | **Not a drawing** — flat black. |

### Priority

`boss_tie`, `boss_pull` and `boss_grip` are the three that carry the scene.
`blackout` needs nothing. `office_close` and `bed_dark` are the two rooms.

## Scenario 5 — Friday

Reuses every background it needs — `openplan_morning`, `small_room`,
`meeting_room`, `kitchenette`, `black`. **No new backgrounds.** Four new
character states, and one set that doesn't exist yet.

### Characters

| Tag | Where it's used | Notes |
|---|---|---|
| `delia, warm, centre` | The mentoring and Culture Club ask. | Pleased, generous, seeking him out for the first time all quarter. She thinks she's doing him a kindness, and she is. |
| `delia, neutral, centre` | Opening the review. | Professional, prepared, forty minutes booked for thirty. **She came in planning to talk about communication style** — nothing in her face should suggest she knows what's coming. |
| `delia, uncertain, centre` | The reveal, and the two earlier moments she gets caught out. | The hardest drawing in the game. She is working something out mid-sentence and doesn't like it. Not tearful, not apologetic — she's a senior person hearing herself say something true. |
| `mahalia, cheerful, right` | **1 line.** "You two should get coffee." | Same Mahalia as scenario 1. Her only appearance outside Monday now that the Wednesday kitchenette beat is cut. |
| `sandes, eager, left` | The sprint review, and both March endings. | Twenty-four, junior, delighted to be here. **Not a younger copy of the PC** — Sandes is better at this than he was, faster to laugh things off. That's the discomfort. |

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

---

## Scenario 4 art — mapping assumptions

Pauleen's Thursday set arrived with descriptive filenames rather than tag names.
Mapped as below. The three marked **?** are guesses from the filename alone and
should be checked by eye in a playthrough — swapping any two is just a rename.

| Her filename | Mapped to | Confidence |
|---|---|---|
| `Blankoffice` | `office_close` | confirmed — empty office desk |
| `Suggestive` | `boss_smirk` | confirmed — leaning on the desk, smiling |
| `Ending` | `boss_release` | confirmed — close-up, reaching, grinning |
| `Clearinglaptop` | `boss_pleased` | ? |
| `Taunting` | `boss_laugh` | ? |
| `Approaching` | `boss_tie` | ? |
| `Gripping` | `boss_pull` | ? |
| `Crazy` | `boss_grip` | ? |
| `Leaving` | `bed_dark` | ? — the weakest of these; `bed_dark` is him awake at night, and a frame called "Leaving" may not be that at all |

`blackout` needs no drawing — the two closing lines play on flat black.
