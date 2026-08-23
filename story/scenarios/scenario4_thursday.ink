// Scenario 4 — Thursday
// Working title: "Performance Check"

VAR standing = 0
VAR composure = 0
VAR froze = false
VAR left_room = false

// ============================================================
// Content warning
//
// The skip has to advance state or the night scene reads wrong for anyone who
// took it, so it sets the same flags a freeze would and applies the composure
// cost before rejoining.
// ============================================================

# cw: sexual_harassment
# background: blackout
This scenario contains workplace sexual harassment, including unwanted physical contact and coercion by a senior colleague.

* [Continue]
    -> scene1_office

* [Skip this scenario]
    -> sc4_skip


=== sc4_skip ===

# background: blackout
# thought
Thursday: a senior colleague keeps him back after hours and makes it clear his job depends on how he responds to her.

# background: blackout
# thought
He gets out of the room. What he does about it is still his to decide.

~ composure = composure - 2
~ froze = true

-> that_night


// ============================================================
// Scene 1 — The Office
// ============================================================
=== scene1_office ===

# background: boss_intro
# thought
Boss told you to stay back for a quick performance check.

# background: boss_showing
# speaker: boss
"So. How has your first week been?"

* ["Good."]
    -> perf_check

* ["It's been a week."]
    -> perf_check

=== perf_check ===

# background: boss_showing
# speaker: boss
"I'm impressed with your performance."

# background: boss_showing
# thought
Thanks, I guess?

# background: boss_showing
# speaker: boss
"I heard you went pretty above and beyond to get this role."

# background: boss_showing
# thought
What the hell does that mean?

# background: boss_showing
# speaker: boss
"Are you somebody's nephew? Or..."

# background: boss_showing
# speaker: boss
"...did you sleep with someone?"

# background: boss_showing
# thought
Tf??????

# background: boss_scolding
# speaker: boss
"Relax. I'm just asking."

# background: boss_scolding
# thought
She's standing in front of you now, playing with your tie.

# background: boss_scolding
# speaker: boss
"I can make things very easy for you here. Or very hard."

# background: boss_scolding
# speaker: boss
"The question is... how badly do you want to stay?"

* ["This is inappropriate."]
    ~ froze = false
    ~ standing = standing + 1
    ~ composure = composure - 1
    -> escalation

* [Freeze]
    ~ froze = true
    ~ composure = composure - 2
    -> escalation

=== escalation ===

// Rapid flash-cut, 0.5s per frame, no tap needed — the scene stops pacing
// like a conversation here on purpose.
# background: clearing_laptop
# flash

# background: Suggestive
# flash

# background: Leaving
# flash

# background: Gripping
# flash

# background: Approaching
# flash

# background: Taunting
# flash

# background: Crazy
# flash

* ["I need to go."]
    ~ left_room = true
    ~ standing = standing + 1
    ~ composure = composure - 1
    -> boss_release

* [Say nothing]
    ~ left_room = false
    ~ composure = composure - 2
    -> boss_release

=== boss_release ===

# background: boss_scolding
# thought
She releases you, smirking.

# background: boss_scolding
# speaker: boss
"I'll see you Monday then. Same time."

-> that_night


// ============================================================
// Scene 2 — That Night
// ============================================================
=== that_night ===

# background: bed_dark
# thought
You're in bed. You can't sleep. You keep thinking about today.

# background: bed_dark
# thought
You're conflicted. You're uncomfortable. You worked really hard for this job. What do you do?

-> ending

=== ending ===

~ composure = composure - 1

# background: blackout
# thought
Risk your career. She's senior. You're new. They'll believe her.

# background: blackout
# thought
Keep your job. Keep your head down. Go to the meeting on Monday.

-> END