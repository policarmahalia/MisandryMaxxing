// Scenario 3 — Wednesday
// Working title: "Version History"
//
// Register: dry, underplayed. Nobody raises their voice. Nothing is provable.
// Thesis: he does the work twice and his name is on it zero times, and there
// is no one to be angry at.
//
// LOCKED:
//   - The swap is never explained. Sarah's account is plausible; so is the
//     other reading. No choice unlocks the truth. If a playtester asks "so did
//     she or didn't she", that's the chapter working.
//   - The credit is not recovered. Every route converges on him redoing it.
//   - No villains. Delia is tired, Sarah is warm, Linda is efficient, Jean is
//     joking, Kiera means it as a compliment. The damage is cumulative and
//     unattributable.
//
// BOSS is named Delia here — Sarah refers to her by that name in Scene 2, so
// the placeholder is doing the work of a name already. Change in one place if
// the team wants something else.

VAR standing = 0
VAR composure = 0

// Carried from Scenario 2 once cross-scenario state exists. Until then these
// start at zero and the chapter reads as a standalone.

VAR asked_sarah = false
VAR named_sarah = false
VAR kept_receipts = false
VAR note_taker = false


// ============================================================
// Scene 1 — The Report
// ============================================================

# background: openplan_morning
# thought
You finalise the system performance report at 10:40. Charts, appendix, the lot.

# background: openplan_morning
# thought
Save to the shared drive, link it to Delia and the wider team, go and get a coffee.

# background: openplan_morning
# thought
At 11:15 Delia is standing at your desk with her laptop open.

# background: openplan_morning
# character: boss, tired, right
# speaker: delia
"This isn't what I was expecting."

# background: openplan_morning
# thought
She turns the screen. It's the report, dated Tuesday, three charts short, the settlement figures un-reconciled. It's a draft you abandoned two days ago.

# background: openplan_morning
# thought
Your name isn't on it. Sarah's is.

# character: boss, tired, right
# speaker: delia
"Sarah's redone most of it from scratch. I'm not thrilled about where that leaves the afternoon."

# background: openplan_morning
# thought
She isn't angry. That's somehow worse.

* ["That's not the version I sent. Check the file history."]
    ~ standing = standing - 1
    ~ composure = composure - 1
    ~ kept_receipts = true
    # character: boss, tired, right
    # speaker: delia
    "I don't need a forensic investigation, I need the report."
    # background: openplan_morning
    # thought
    She's already looking at her phone.
    # speaker: delia
    "Can you have it by four?"
    -> sc1_converge

* ["Sarah must have overwritten it."]
    ~ standing = standing - 2
    ~ composure = composure + 1
    ~ named_sarah = true
    # background: openplan_morning
    # thought
    A pause.
    # character: boss, cool, right
    # speaker: delia
    "Let's not do that."
    # character: boss, cool, right
    # speaker: delia
    "Just get me the corrected one."
    -> sc1_converge

* ["I'll fix it."]
    ~ composure = composure - 2
    # character: boss, tired, right
    # speaker: delia
    "Thank you."
    # background: openplan_morning
    # thought
    She means it. She's gone in four seconds.
    -> sc1_converge

* ["Can I ask Sarah what she was working from?"]
    ~ standing = standing - 1
    ~ asked_sarah = true
    # character: boss, tired, right
    # speaker: delia
    "Sure. After four."
    -> sc1_converge


=== sc1_converge ===

# background: openplan_morning
# thought
You open the shared drive. There's one file. Modified 09:52 by Sarah.

# background: openplan_morning
# thought
There's no earlier version in the folder. There might have been, and there might not have been. You are not going to be able to find out this afternoon.

// Players who didn't ask never get Sarah's side. That's a different
// playthrough, not a missed one.
{asked_sarah:
    -> sc2_sarah
- else:
    -> sc3_kitchenette
}


// ============================================================
// Scene 2 — Sarah  (conditional on asked_sarah)
// ============================================================
=== sc2_sarah ===

# background: kitchenette
# character: sarah, warm, left
# thought
She's genuinely pleased to see you.

# character: sarah, warm, left
# speaker: sarah
"Oh — the perf report? Yeah, I found it Tuesday night and it was in rough shape, so I just took a run at it."

# character: sarah, warm, left
# speaker: sarah
"Was that a live one? God, I'm sorry, it looked like a stale draft."

# character: sarah, warm, left
# speaker: sarah
"Did you have a newer one somewhere? I would've just used yours."

* ["I sent the newer one this morning."]
    ~ composure = composure - 1
    # character: sarah, warm, left
    # speaker: sarah
    "Weird. Ping it to me and I'll tell Delia it was yours."
    # background: kitchenette
    # thought
    She doesn't. Not out of malice — the day gets away from her, the same way it gets away from everyone.
    -> sc3_kitchenette

* ["No, that was probably it."]
    ~ standing = standing + 1
    ~ composure = composure - 2
    # background: kitchenette
    # thought
    You watch yourself do it. She is relieved and you are the reason.
    -> sc3_kitchenette

* ["You could have asked me first."]
    ~ standing = standing - 1
    ~ composure = composure + 1
    # character: sarah, warm, left
    # speaker: sarah
    "You're right. That's fair."
    # background: kitchenette
    # thought
    She says it immediately and completely, and it changes nothing, because the report still says Sarah.
    -> sc3_kitchenette


// ============================================================
// Scene 3 — Small Things
// ============================================================
=== sc3_kitchenette ===

// 3a — no fork. Ten seconds long, and it lands harder as something that
// simply happens to him.

# background: kitchenette
# thought
Half four. You're the last one near the kitchenette, so you're the one who's asked to sort it before you go.

# character: kiera, cheerful, right
# speaker: kiera
"You're good at this, though. Look at that."

# character: kiera, cheerful, right
# speaker: kiera
"You clean up so well."

# background: kitchenette
# thought
She means it as a compliment. It is one, structurally.

~ composure = composure - 1

// 3b — the thread

# background: slack_ui
# thought
The #platform-eng thread is arguing about connection pooling. You post the actual answer, with a link to the config.

# background: slack_ui
# thought
Nothing.

# background: slack_ui
# thought
Forty minutes later the thread resolves without you, in the direction you pointed it.

~ composure = composure - 1

// 3c — Jean

# background: slack_ui
# thought
You DM Jean asking for ten minutes on a deploy issue.

# background: slack_ui
# speaker: jean
"sure — what do i get in return 😉"

* ["A working deploy."]
    ~ standing = standing + 1
    ~ composure = composure - 1
    # background: slack_ui
    # speaker: jean
    "hahaha ok ok. 5 mins."
    # background: slack_ui
    # thought
    She helps. She's good. It was a joke.
    -> sc4_meeting

* ["lol"]
    ~ composure = composure - 2
    # background: slack_ui
    # speaker: jean
    "gimme 5."
    # background: slack_ui
    # thought
    She helps. She's good. It was a joke.
    -> sc4_meeting

* [Close the DM. Work it out yourself.]
    ~ standing = standing - 1
    ~ composure = composure - 1
    # background: slack_ui
    # thought
    It takes you until 18:20.
    -> sc4_meeting


// ============================================================
// Scene 4 — The Sync
// ============================================================
=== sc4_meeting ===

# background: meeting_room
# thought
Five past five. You've re-cut the report and you're presenting it in ten minutes.

# character: linda, neutral, centre
# speaker: linda
"Before we start — someone needs to take the minutes."

# background: meeting_room
# thought
She looks around the table. The look completes on you. It always completes on you.

* ["Sure."]
    ~ standing = standing - 1
    ~ composure = composure - 1
    ~ note_taker = true
    # background: meeting_room
    # thought
    You open a doc.
    -> sc4_body

* [Say nothing. Open a doc.]
    ~ standing = standing - 1
    ~ composure = composure - 2
    ~ note_taker = true
    # background: meeting_room
    # thought
    Nobody has to ask twice. That's the part that stays with you.
    -> sc4_body

// Not a win. It reads as a condition attached to a small favour, and it buys
// a rotation that never materialises. Costed accordingly.
* ["Happy to, if we rotate it after this."]
    ~ standing = standing - 1
    ~ composure = composure + 1
    ~ note_taker = true
    # character: linda, neutral, centre
    # speaker: linda
    "Sure."
    # background: meeting_room
    # thought
    She writes nothing down. You still take them today.
    -> sc4_body

* ["I'm presenting in ten — I'd rather not be typing through it."]
    ~ standing = standing + 1
    ~ composure = composure - 1
    # character: linda, neutral, centre
    # speaker: linda
    "Fair."
    # character: linda, neutral, centre
    # speaker: linda
    "Chesca?"
    # background: meeting_room
    # thought
    Chesca takes them without comment. It was that easy for someone. It was never going to be that easy for you, and you've spent something to find out.
    -> sc4_body


=== sc4_body ===

# character: linda, neutral, centre
# speaker: linda
"Settlement job. The retry logic's double-firing on the reconciliation batch."

# background: meeting_room
# thought
You know the answer. It's the same idempotency problem from the report you wrote twice.

{note_taker:
    -> sc4_ghost
- else:
    -> sc4_speak
}


= sc4_speak

* ["That's idempotency. The retry key isn't scoped to the batch."]
    ~ standing = standing + 1
    -> sc4_resolve

* ["We flagged this in the design review."]
    ~ standing = standing + 1
    ~ composure = composure - 1
    -> sc4_resolve


// The single most important four seconds in the chapter: the player reaches
// for an option and finds it isn't theirs. inkjs has no disabled choice, so
// the option text ships as a tag and the renderer draws it unclickable.
= sc4_ghost

# background: meeting_room
// The pipe is escaped because ink reserves | as its alternative separator.
// It survives into the tag value intact, so TagParser still splits on "|".
# ghost_choices: "That's idempotency. The retry key isn't scoped to the batch."\|"We flagged this in the design review."
# thought
Both hands on the keyboard. Someone is mid-sentence and you are three words behind.

~ composure = composure - 2

-> sc4_resolve


=== sc4_resolve ===

# character: chesca, neutral, left
# speaker: chesca
"Is it an idempotency thing? Like, is the retry key scoped to the batch?"

# character: linda, neutral, centre
# speaker: linda
"Probably. Good — Chesca, can you take a look tomorrow?"

# background: meeting_room
# thought
You present the report. It's good. It's better than the first one. Two people say so.

-> sc5_pr


// ============================================================
// Scene 5 — The PR
// ============================================================
=== sc5_pr ===

# background: home_evening
# thought
21:40. You open a PR for the pooling fix — the one from the thread nobody answered.

# background: home_evening
# thought
Morning: forty-one comments. Naming conventions. A suggestion to split a nine-line function. Two people asking whether you'd considered an approach you'd considered and rejected in the description.

# background: home_evening
# thought
One of them is Sarah, and it's the most useful review on there. She's spent twenty minutes on it. She's being kind.

# background: home_evening
# thought
Chesca's PR, opened the same night, four files changed.

# background: home_evening
# thought
LGTM.

~ composure = composure - 1

# background: home_evening
# thought
The corrected report goes out at 09:02, in a shared folder with no author field.

# module: quiz3

-> END
