# Scene art needed

Every `# scene: name` tag in an `.ink` file loads `public/assets/scenes/<name>.png`.

**Filenames must be lowercase and match the tag exactly.** macOS won't complain
if the case is wrong but Vite's dev server and GitHub Pages both will — that's
what caused the broken images in scenario 1.

**Spec:** 1951 × 1100 PNG, matching the existing set (line-art characters over a
desaturated open-plan office photo).

---

## Already drawn

`intro` · `surprised` · `shocked` · `sideeyeing` · `checking` · `pointing` ·
`judgemental` · `listening`

Scenario 3 reuses **checking**, **judgemental**, **pointing** and **sideeyeing**
as-is. `listening` is drawn but unused so far — worth a look, it may cover one of
the below.

---

## Needed for scenario 3

### Tier 1 — the chapter doesn't read without these

| Tag | Scene | Notes |
|---|---|---|
| `desk` | His own desk, report on the monitor | The workhorse. Opens the chapter, returns four times, and is the fallback for any Tier 2 shot that doesn't get drawn. Draw this first. |
| `boss_furious` | **Linda** standing over his desk, laptop in hand, genuinely angry | The chapter's hardest beat. Anger, not comedy — if she reads as a caricature the scene stops working. |
| `laptop_evidence` | Close on a laptop screen: an old, error-strewn report with **Sarah's** name in the author field | The one shot the player needs to actually read. Keep the name legible; that's the gut punch. |
| `meeting_room` | Panel meeting, tense, several colleagues seated | Used across the whole minutes sequence, which is the only choice point in the chapter. |
| `kitchenette` | Office kitchenette, him with a cloth, **Keira** in the doorway | Needs to feel ordinary, not menacing. The line does the work. |

### Tier 2 — fall back to `desk` if time runs out

| Tag | Scene | Notes |
|---|---|---|
| `slack_thread` | A chat thread on screen, his message sitting unanswered above later replies | If drawn, make the visual gap obvious — his message with nothing under it. |
| `jean_desk` | **Jean** swivelled round from the next desk, unsmiling | "What do I get in return?" She isn't joking, and her face shouldn't say she is. |
| `pr_comments` | A pull request with a wall of review comments, and beside it another PR with one comment reading `LGTM` | The chapter's closing image. Works best if the two are visibly side by side. |

---

## Characters appearing

- **Linda** — senior director. In `boss_furious`, `meeting_room`, and reuses `pointing` / `sideeyeing` / `judgemental`.
- **Keira** — in `kitchenette`, reuses `checking`. Already designed in scenario 1.
- **Jean** — new. Only needs `jean_desk`.
- **Sarah** — named constantly, never on screen. **She doesn't need a design** unless you want her visible in `meeting_room`, and leaving her off-screen is arguably better — the chapter is stronger if we never get to read her face.

---

## If the art runs out of time

The scenes degrade gracefully to `desk`, and a chapter carried on five images
plus the four reused ones still plays. Don't let missing art block writing
scenarios 2, 4 and 5 — the tags can point at `desk` and be swapped later with a
find-and-replace.
