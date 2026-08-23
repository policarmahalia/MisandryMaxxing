// Scenario 4 — Thursday
// Working title: "Performance Check"

VAR standing = 0
VAR composure = 0
VAR froze = false
VAR left_room = false

// ============================================================
// Scene 1 — The Office
// ============================================================

# background: office_close
# thought
Boss told you to stay back for a quick performance check.

# background: office_close
# speaker: boss
"So. How has your first week been?"

* ["Good."]
    -> perf_check

* ["It's been a week."]
    -> perf_check

=== perf_check ===

# background: boss_pleased
# speaker: boss
"I'm impressed with your performance."

# background: boss_pleased
# thought
Thanks, I guess?

# background: boss_smirk
# speaker: boss
"I heard you went pretty above and beyond to get this role."

# background: boss_smirk
# thought
What the hell does that mean?

# background: boss_smirk
# speaker: boss
"Are you somebody's nephew? Or..."

# background: boss_smirk
# speaker: boss
"...did you sleep with someone?"

# background: boss_smirk
# thought
Tf??????

# background: boss_laugh
# speaker: boss
"Relax. I'm just asking."

# background: boss_tie
# thought
She's standing in front of you now, playing with your tie.

# background: boss_tie
# speaker: boss
"I can make things very easy for you here. Or very hard."

# background: boss_tie
# speaker: boss
"The question is... how badly do you want to stay?"

* ["This is inappropriate."]
    ~ froze = false
    ~ standing = standing + 1
    ~ composure = composure - 1
    -> boss_touch

* [Freeze]
    ~ froze = true
    ~ composure = composure - 2
    -> boss_touch

=== boss_touch ===

# background: boss_pull
# thought
Her hand slides down your arm.

# background: boss_pull
# speaker: boss
"Think about it. A good word from me goes a long way."

# background: boss_grip
# speaker: boss
"Or maybe you want to make things really easy for yourself."

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

# background: boss_release
# thought
She releases you, smirking.

# background: boss_release
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