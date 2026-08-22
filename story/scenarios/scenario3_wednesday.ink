// Scenario 3 — Wednesday
// Five small humiliations in one day: the sabotaged report, the kitchenette,
// the invisible thread, the minutes, the pull request.
//
// STRUCTURE NOTE: this chapter is deliberately almost entirely linear. The day
// happens TO him. The single choice point is the minutes, and it lands harder
// for being the only one. Composure drains passively through the other scenes —
// they cost him something whether or not he can act on them.
//
// Sarah's motive is never resolved. Whether she overwrote the file on purpose
// or by accident is not the point. The point is that nobody asked.

VAR standing = 0
VAR composure = 0

VAR pushed_minutes = false
VAR silenced = false

# scene: desk
# thought
Wednesday. The system performance report has been three weeks of your life.

# scene: desk
# thought
You save the final version to the shared drive, send the link to Linda and the wider team, and go to get a coffee.

-> the_report


// ============================================================
// Scene 1 — The Incompetence. No choices. He does not get one.
// ============================================================
=== the_report ===

# scene: boss_furious
# speaker: linda
"What is this garbage you sent?"

# scene: desk
# thought
Linda is standing at your desk. You have never seen her look like this.

# speaker: you
"What? I sent the finalized report, it should be..."

# scene: laptop_evidence
# thought
She shoves her laptop at you.

# scene: laptop_evidence
# thought
The report on the screen is dated. It's full of errors you fixed a fortnight ago. It isn't your version, and your name isn't on it anywhere.

# scene: laptop_evidence
# thought
Sarah's is.

~ composure = composure - 3

# scene: judgemental
# speaker: linda
"I'm starting to question your competence. Sarah seems to have had to redo the whole thing from scratch."

# scene: judgemental
# speaker: linda
"Get it fixed. And don't let me down again."

~ standing = standing - 2

# scene: desk
# thought
She walks off before you have finished deciding what you would have said.

# scene: desk
# thought
Nobody at the surrounding desks looks up.

# scene: desk
# thought
The rest of the day is a series of small, frustrating humiliations.

-> the_kitchenette


// ============================================================
// Scene 2 — The Kitchenette
// ============================================================
=== the_kitchenette ===

# scene: kitchenette
# thought
On your way out you're asked to stay behind and wipe down the kitchenette. You seem like you'd be good at it, apparently.

# scene: checking
# speaker: keira
"Wow. You clean up so well."

~ composure = composure - 1

# scene: kitchenette
# thought
You keep wiping the same clean patch of bench until she leaves.

-> the_thread


// ============================================================
// Scene 3 — Slack
// ============================================================
=== the_thread ===

# scene: slack_thread
# thought
Back at your desk, someone posts a question about connection pooling. You know the answer. You write it out properly, with a link to the docs.

# scene: slack_thread
# thought
Nothing. The thread moves on around your message like water around a rock.

# scene: slack_thread
# thought
Twenty minutes later it's still sitting there, unanswered, above three replies to somebody else.

~ composure = composure - 1

# scene: jean_desk
# thought
You turn to Jean and ask for a hand with a bug you've been stuck on since lunch.

# scene: jean_desk
# speaker: jean
"What do I get in return?"

# scene: jean_desk
# thought
You wait for her to smile. She doesn't.

~ composure = composure - 1

-> the_minutes


// ============================================================
// Scene 4 — The Second Meeting. The only choice in the chapter.
// ============================================================
=== the_minutes ===

# scene: meeting_room
# thought
Another meeting. You're on the panel presenting the corrected report. The atmosphere is tense before anyone has spoken.

# scene: pointing
# speaker: linda
"Alright, someone needs to take the minutes."

# scene: pointing
# thought
She looks around the room. Her eyes land on you and stop there.

# speaker: linda
"Anyone?"

# scene: meeting_room
# thought
You can feel everyone waiting.

* [Say nothing. Open a document.]
    ~ silenced = true
    ~ standing = standing - 2
    ~ composure = composure - 2
    # scene: meeting_room
    # thought
    You don't speak. You just start typing.
    # scene: meeting_room
    # thought
    You keep your head down, and you can feel the power drain out of you. You are the note-taker now, and you don't say another word for the rest of the hour.
    -> the_pr

* ["Sure."]
    ~ standing = standing - 1
    ~ composure = composure - 1
    # scene: meeting_room
    # thought
    You agree, and feel the control slip away as you say it.
    -> the_pr

* ["Happy to, if we rotate it after this one."]
    ~ pushed_minutes = true
    ~ standing = standing - 1
    ~ composure = composure + 1
    # scene: sideeyeing
    # speaker: linda
    "Wow. A team player with conditions."
    # scene: sideeyeing
    # speaker: linda
    "Fine. You do it."
    # scene: meeting_room
    # thought
    It was fair, and it worked, and somehow you're the one who came out of it looking petty.
    -> the_pr

* ["I'd rather follow this properly. I'm presenting after."]
    ~ pushed_minutes = true
    ~ standing = standing + 1
    ~ composure = composure - 1
    # scene: meeting_room
    # thought
    Linda scoffs, but she turns away from you.
    # speaker: linda
    "Fine. Sarah, take them down."
    # scene: meeting_room
    # thought
    You kept your stance. It cost more than it should have.
    -> the_pr


// ============================================================
// Scene 5 — The PR. Coda. No choices.
// ============================================================
=== the_pr ===

# scene: desk
# thought
You finish the day by putting up a pull request for a new feature. It's a solid piece of code and you know it.

# scene: pr_comments
# thought
You wake the next morning to forty comments.

# scene: pr_comments
# thought
Naming. Spacing. A suggestion to rename a variable back to what it was called before you renamed it. A question about a decision that is explained on the line directly above it.

# scene: pr_comments
# thought
Out of curiosity, you open Sarah's pull request from the same afternoon.

# scene: pr_comments
# thought
One comment.

~ composure = composure - 1

# scene: pr_comments
# thought
LGTM.

-> END
