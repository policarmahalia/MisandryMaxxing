// Scenario 3 — Wednesday
// Working title: "Version History"
//
// Register: dry, underplayed. Nobody raises their voice. Nothing is provable.
// Thesis: he does the work twice and his name is on it zero times, and there
// is no one to be angry at.
//
// LOCKED:
//   - The swap is never explained. Pauline's account is plausible; so is the
//     other reading. No choice unlocks the truth. If a playtester asks "so did
//     she or didn't she", that's the chapter working.
//   - The credit is not recovered. Every route converges on him redoing it.
//   - The sync scene was cut: scenario 2 already carries the note-taker beat,
//     and the ghost-choice mechanic moved there with it.
//   - No villains. Delia is tired, Pauline is warm, Reyana is efficient and
//     Fiona is joking. The damage is cumulative and unattributable.
//
// Delia is the senior director. She is NOT the BOSS character from Scenario 2
// and 4 — that's a different, deliberately unnamed person, and Scenario 4
// depends on them being distinct.

VAR standing = 0
VAR composure = 0

// Carried from Scenario 2 once cross-scenario state exists. Until then these
// start at zero and the chapter reads as a standalone.

VAR asked_pauline = false
VAR named_pauline = false
VAR kept_receipts = false


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
# character: delia, tired, right
# speaker: Delia
"This isn't what I was expecting."

# background: openplan_morning
# thought
She turns the screen. It's the report, dated Tuesday, three charts short, the settlement figures un-reconciled. It's a draft you abandoned two days ago.

# background: openplan_morning
# thought
Your name isn't on it. Pauline's is.

# character: delia, tired, right
# speaker: Delia
"Pauline's redone most of it from scratch. I'm not thrilled about where that leaves the afternoon."

# background: openplan_morning
# thought
She isn't angry. That's somehow worse.

* ["That's not the version I sent. Check the file history."]
    ~ standing = standing - 1
    ~ composure = composure - 1
    ~ kept_receipts = true
    # character: delia, tired, right
    # speaker: Delia
    "I don't need a forensic investigation, I need the report."
    # background: openplan_morning
    # thought
    She's already looking at her phone.
    # speaker: Delia
    "Can you have it by four?"
    -> sc1_converge

* ["Pauline must have overwritten it."]
    ~ standing = standing - 2
    ~ composure = composure + 1
    ~ named_pauline = true
    # background: openplan_morning
    # thought
    A pause.
    # character: delia, cool, right
    # speaker: Delia
    "Let's not do that."
    # character: delia, cool, right
    # speaker: Delia
    "Just get me the corrected one."
    -> sc1_converge

* ["I'll fix it."]
    ~ composure = composure - 2
    # character: delia, tired, right
    # speaker: Delia
    "Thank you."
    # background: openplan_morning
    # thought
    She means it. She's gone in four seconds.
    -> sc1_converge

* ["Can I ask Pauline what she was working from?"]
    ~ standing = standing - 1
    ~ asked_pauline = true
    # character: delia, tired, right
    # speaker: Delia
    "Sure. After four."
    -> sc1_converge


=== sc1_converge ===

# background: openplan_morning
# thought
You open the shared drive. There's one file. Modified 09:52 by Pauline.

# background: openplan_morning
# thought
There's no earlier version in the folder. There might have been, and there might not have been. You are not going to be able to find out this afternoon.

// Players who didn't ask never get Pauline's side. That's a different
// playthrough, not a missed one.
{asked_pauline:
    -> sc2_pauline
- else:
    -> sc3_small_things
}


// ============================================================
// Scene 2 — Pauline  (conditional on asked_pauline)
//
// NOTE: this is set in the kitchenette, but it is NOT the cut kitchenette
// beat. Mahalia's "you clean up so well" is gone. This is Pauline
// apologising, and it reuses the same room.
// ============================================================
=== sc2_pauline ===

# background: kitchenette
# character: pauline, warm, left
# thought
She's genuinely pleased to see you.

# character: pauline, warm, left
# speaker: Pauline
"Oh — the perf report? Yeah, I found it Tuesday night and it was in rough shape, so I just took a run at it."

# character: pauline, warm, left
# speaker: Pauline
"Was that a live one? God, I'm sorry, it looked like a stale draft."

# character: pauline, warm, left
# speaker: Pauline
"Did you have a newer one somewhere? I would've just used yours."

* ["I sent the newer one this morning."]
    ~ composure = composure - 1
    # character: pauline, warm, left
    # speaker: Pauline
    "Weird. Ping it to me and I'll tell Delia it was yours."
    # background: kitchenette
    # thought
    She doesn't. Not out of malice — the day gets away from her, the same way it gets away from everyone.
    -> sc3_small_things

* ["No, that was probably it."]
    ~ standing = standing + 1
    ~ composure = composure - 2
    # background: kitchenette
    # thought
    You watch yourself do it. She is relieved and you are the reason.
    -> sc3_small_things

* ["You could have asked me first."]
    ~ standing = standing - 1
    ~ composure = composure + 1
    # character: pauline, warm, left
    # speaker: Pauline
    "You're right. That's fair."
    # background: kitchenette
    # thought
    She says it immediately and completely, and it changes nothing, because the report still says Pauline.
    -> sc3_small_things


// ============================================================
// Scene 3 — Small Things
// (the kitchenette beat was cut; this opens on the thread now)
// ============================================================
=== sc3_small_things ===

// 3b — the thread

# background: slack_ui
# thought
The \#platform-eng thread is arguing about connection pooling. You post the actual answer, with a link to the config.

# background: slack_ui
# thought
Nothing.

# background: slack_ui
# thought
Forty minutes later the thread resolves without you, in the direction you pointed it.

~ composure = composure - 1

// 3c — Fiona

# background: slack_ui
# thought
You DM Fiona asking for ten minutes on a deploy issue.

# background: slack_ui
# speaker: Fiona
"sure — what do i get in return 😉"

* ["A working deploy."]
    ~ standing = standing + 1
    ~ composure = composure - 1
    # background: slack_ui
    # speaker: Fiona
    "hahaha ok ok. 5 mins."
    # background: slack_ui
    # thought
    She helps. She's good. It was a joke.
    -> sc4_pr

* ["lol"]
    ~ composure = composure - 2
    # background: slack_ui
    # speaker: Fiona
    "gimme 5."
    # background: slack_ui
    # thought
    She helps. She's good. It was a joke.
    -> sc4_pr

* [Close the DM. Work it out yourself.]
    ~ standing = standing - 1
    ~ composure = composure - 1
    # background: slack_ui
    # thought
    You're still on it when the sync starts.
    -> sc4_pr


// ============================================================
// Scene 4 — The PR
// ============================================================
=== sc4_pr ===

# background: home_evening
# thought
21:40. You open a PR for the pooling fix — the one from the thread nobody answered.

# background: home_evening
# thought
Morning: forty-one comments. Naming conventions. A suggestion to split a nine-line function. Two people asking whether you'd considered an approach you'd considered and rejected in the description.

# background: home_evening
# thought
One of them is Pauline, and it's the most useful review on there. She's spent twenty minutes on it. She's being kind.

# background: home_evening
# thought
Ellie's PR, opened the same night, four files changed.

# background: home_evening
# thought
LGTM.

~ composure = composure - 1

# background: home_evening
# thought
The corrected report goes out at 09:02, in a shared folder with no author field.

# module: quiz3

-> END
