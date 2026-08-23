# Scenario 5: Friday — "Calibration"

For Pauleen. Same format as the Scenario 1 breakdown.

**This is the last chapter.** It jumps forward in the middle: Scene 1–2 are Friday
morning of week one, then a card skips eleven weeks to the performance review.

---

## Summary

* Eleven weeks after the rest of the game. A new starter has arrived — **Sandes**,
  the other guy, junior, twenty-four, delighted to be here.
* Everyone assumes the two men should be friends, and you get handed the
  mentoring plus an unpaid committee seat in the same breath.
* You watch Sandes get talked over in a meeting exactly the way you used to be,
  and have to decide whether to spend your own standing defending him.
* Your performance review is strong on delivery and vague on "communication
  style". **Delia** finally explains why she went cold on you in week six — and
  realises, mid-sentence, what it cost you.
* Three different endings depending on how you played the whole game.
* End of the scenario: **"What was wrong"** quiz.

---

## Beat by beat

1. **Scene 1 — open plan, morning.** `openplan_morning`
   [There's a new starter on the floor. Backend, junior, started Monday.]
   [Two people mention it to you before ten. Both of them mention it the same way.]
   **Mahalia:** ["Have you met Sandes? You two should get coffee."]

2. **Scene 2 — small meeting room.** `small_room` · **Delia, warm**
   **Delia:** ["Sandes — I'd like you to mentor him. Informally, nothing heavy.
   You've had a harder ramp than you should have and I think that makes you good
   at it."]
   [It's a compliment. It's also the first time all quarter she's sought you out.]
   **Delia:** ["Also — Culture Club's short a rep and I put your name down. It's
   an hour a fortnight."]

3. **Choice (4 options).** `small_room`
   * ["Happy to do both."]
   * ["Mentoring yes. Culture Club, can I pass?"]
   * ["Why me for Culture Club?"] → **Delia, uncertain** — she stops mid-word
   * (Say yes to everything. Don't ask.)

4. **Scene 3 — time skip card.** `black`
   [Eleven weeks.]
   [The settlement migration ships. Twice you ask someone to pair on it and twice
   they're honest about being busy, and you do it alone, and it takes forty
   percent longer than it should have.]
   [Your face is still on the careers page.]

5. **Scene 4 — the meeting room, sprint review.** `meeting_room` · **Sandes, eager**
   [Sandes says the thing about the connection pool, and it's right, and it goes
   past the room like a car going past a bus stop.]
   [Four minutes. Then Ellie says it back, slightly better.]
   **Reyana:** ["Nice one, Ellie."]
   [Sandes's face does the exact thing you've spent three months learning not to
   let your face do.]

6. **Choice (3 options) — this one decides the ending.** `meeting_room`
   * ["That was Sandes's, four minutes ago."] ← the only route to the good ending
   * (Message Sandes privately: "that was yours.")
   * (Say nothing.)

7. **Scene 5 — the review.** `small_room` · **Delia, neutral**
   **Delia:** ["Delivery's strong. Where it gets complicated is communication style."]
   **Delia:** ["There's a perception you're — the word that came back twice was
   prickly. Once was hard to read."]

8. **Choice (4 options).** `small_room`
   * ["Prickly compared to who?"] → **Delia, uncertain**
   * ["Understood. I'll work on it."]
   * ["Can I say something properly?"] → leads to the reveal below
   * (Nod. Let her finish.)

9. **Scene 6 — the reveal.** `small_room` · **Delia, uncertain** — *the hardest
   drawing in the game, see notes*
   **Delia:** ["When the thing went round about how you got the ledger work — I
   heard it in week six. And the correct move, obviously, is to shut it down.
   Publicly. Be seen backing you."]
   **Delia:** ["And I didn't, because if I'd stood up in front of the floor and
   defended you, every single person in that room would have decided that
   confirmed it."]
   **Delia:** ["So the smart thing was distance. Give it nothing to feed on. Let
   it starve."]
   **Delia:** ["And it did starve, more or less, and—"]
   *(the sentence doesn't finish)*
   **Delia:** ["...and you did the whole migration on your own."]
   [Silence.]
   **Delia:** ["I took the one person who could have said 'he's good, I hired him,
   that's the end of it' — and I removed her. That was me. I did that."]
   **Delia:** ["I don't know what to do with that. I'm going to have to sit with it."]

10. **Ending A — Palatable.** `openplan_morning`
    [The promotion goes through in January. It's real and you earned it, and the
    way you earned it was by becoming easy to have around.]
    [March. Sandes catches you by the window and asks how you handle Mahalia.]
    **You:** ["Ah — just laugh it off, mate. It's not worth it."]
    [He looks relieved. That's the worst part. He looks relieved.]

11. **Ending B — Intact.** `small_room`
    [The rating is "meets expectations." The promotion goes to someone else and
    the reason given is communication style.]
    [You're still here. You still recognise yourself.]

12. **Ending C — The one worth having.** `kitchenette`
    [March. Sandes catches you by the window and asks how you handle Mahalia.]
    **You:** ["You're allowed to mind."]
    **You:** ["It'll cost you. I'm not going to tell you it won't. But you're
    allowed to mind, and I'll back you if you say something, and I'll say it
    first if you want me to."]

13. **Closing card.** `black`
    [Nothing here was invented.]
    [Every scene you have just played is drawn from documented accounts of women
    working in engineering and technology.]
    [The only thing that was changed was who it happened to.]

---

## Art needed

Five backgrounds, **none of them new to the game** — all five are also used by
Wednesday or Thursday, so they earn their cost more than once.

| Tag | Where in Friday | Feel |
|---|---|---|
| `openplan_morning` | Scene 1, and Ending A | Ordinary morning. Also needed by Thursday. |
| `small_room` | Scenes 2, 5, 6, and Ending B | A small booked room. Carries the review and the reveal, so it's the most-used room in the chapter. Also needed by Thursday. |
| `meeting_room` | Scenes 4 and 6 | Sprint review, several people seated, a screen. |
| `kitchenette` | Ending C | Warm. The only ending the game is kind about. Also needed by Thursday. |
| `black` | Time skip and closing card | **Not a drawing** — flat black, already handled in code. |

### Characters

| Tag | Where | Notes |
|---|---|---|
| `delia, warm` | Scene 2 | Pleased, generous, seeking him out for the first time all quarter. |
| `delia, neutral` | Scene 5 | Professional, forty minutes booked for thirty. **She came in planning to talk about communication style** — nothing in her face should hint at what's coming. |
| `delia, uncertain` | Scenes 3, 8, 9 | The hardest one. She is working something out mid-sentence and doesn't like it. **Not tearful, not apologetic** — a senior person hearing herself say something true. |
| `sandes, eager` | Scene 4, Endings A and C | Twenty-four, junior, delighted to be here. **Not a younger copy of the player character** — Sandes is better at this than he was, quicker to laugh things off. That's the discomfort. |

---

## Names — please use these

The Slack screens use the old cast names. When you next export anything with a
name in it:

| In the art now | Should be |
|---|---|
| Jean | **Fiona** |
| Linda | **Reyana** |
| Sarah | **Pauline** |

One frame — the #platform-eng thread — has **Linda and Reyana as two separate
people**, but Linda *is* Reyana, so she appears twice under both names.

Filenames: **lowercase, no spaces, no brackets, `.png` not `.PNG`.** They're used
directly as tags, so `Wednesday Slack (1).png` can't be loaded — it has to be
something like `slack_posted.png`. Re-exports keeping the same filename drop
straight in with no code change.
