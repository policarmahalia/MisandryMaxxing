// Scenario 3 — Wednesday
// Working title: "Version History"
//
// Register: dry, underplayed. Nobody raises their voice.
// Thesis: he does the work twice and his name is on it zero times.
//
// LOCKED:
//   - Pauline's name is on the report and she keeps the credit. This used to
//     be deliberately ambiguous with an apology scene giving her side; both
//     were cut. She takes it, nobody investigates, and he redoes the work.
//   - The credit is not recovered. Every route converges on him redoing it.
//   - The sync scene was cut: scenario 2 already carries the note-taker beat,
//     and the ghost-choice mechanic moved there with it.
//   - Delia isn't angry, she's unbothered. That's what makes it land.
//
// Delia is the senior director. She is NOT the BOSS character from Scenario 2
// and 4 — that's a different, deliberately unnamed person, and Scenario 4
// depends on them being distinct.

VAR standing = 0
VAR composure = 0

// Carried from Scenario 2 once cross-scenario state exists. Until then these
// start at zero and the chapter reads as a standalone.

VAR named_pauline = false
VAR kept_receipts = false


// ============================================================
// Scene 1 — The Report
// ============================================================

# background: boss_intro
# thought
You finalise the system performance report at 10:40. Charts, appendix, the lot.

# background: boss_intro
# thought
Save to the shared drive, link it to Delia and the wider team, go and get a coffee.

# background: boss_intro
# thought
At 11:15 Delia is standing at your desk with her laptop open.

# background: boss_scolding
# speaker: Delia
"I'm not seeing anything from you this quarter."

# background: boss_showing
# thought
She turns the screen. It's your report — your charts, your figures, the appendix you rebuilt on Monday.

# background: boss_showing
# thought
Pauline's name is on it. Yours isn't anywhere.

# background: boss_scolding
# speaker: Delia
"Pauline's been carrying this. I need to see you pulling your weight."

# background: boss_intro
# thought
She isn't angry. She's barely interested. That's somehow worse.

* ["That's my report. My name was on it this morning."]
    ~ standing = standing - 1
    ~ composure = composure - 1
    ~ kept_receipts = true
    # background: boss_scolding
    # speaker: Delia
    "I don't need a forensic investigation, I need the work."
    # background: boss_intro
    # thought
    She's already looking at her phone.
    # speaker: Delia
    "Can you have it by four?"
    -> sc1_converge

* ["Pauline put her name on my work."]
    ~ standing = standing - 2
    ~ composure = composure + 1
    ~ named_pauline = true
    # background: boss_intro
    # thought
    A pause.
    # background: boss_scolding
    # speaker: Delia
    "Let's not do that."
    # background: boss_scolding
    # speaker: Delia
    "Just get me the corrected one."
    -> sc1_converge

* ["I'll fix it."]
    ~ composure = composure - 2
    # background: boss_scolding
    # speaker: Delia
    "Thank you."
    # background: boss_intro
    # thought
    She means it. She's gone in four seconds.
    -> sc1_converge


=== sc1_converge ===

# background: boss_intro
# thought
You open the shared drive. There's one file. Modified 09:52 by Pauline.

# background: boss_intro
# thought
You do it again. It takes until four, and it is the second time you have written this report.

-> sc3_small_things


// ============================================================
// Scene 3 — Small Things
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
