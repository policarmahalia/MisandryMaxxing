// Same grammar as scenario 1. Day two, so still small numbers — the chapters
// that hurt are Wednesday onward.
VAR standing = 0
VAR composure = 0

VAR agreed_to_notes = false
VAR pushed_back_day2 = false

// Scene 1 — meeting room, waiting to present
# scene: intro_ignoring
# thought
It's your second day. You're in the meeting, mentally preparing to deliver a technical solution you spent half the night perfecting. You're ready. You're confident. You're about to crush it. Your turn is next.

# scene: staring
# speaker: BOSS
"Hey, sweetie! Last minute change. You're not presenting anymore."

# thought
[Spit-take your coffee] What????

# scene: staring
# speaker: BOSS
"Yeah... we need a note taker for the meeting. You can do that for us, right?"

# thought
I spent all night preparing? What should I do?

* [Agree to be the minute taker]
    ~ standing = standing - 1
    ~ composure = composure - 2
    ~ agreed_to_notes = true
    "Sure... I guess I'll just... take notes."
    # thought
    [Soul leaves body]
    -> notetaking

* [Insist that you present your assigned task]
    ~ standing = standing - 1
    ~ composure = composure + 1
    ~ pushed_back_day2 = true
    "Actually, I'd really like to present. I've prepared extensively."
    -> pushback_reaction

=== pushback_reaction ===
# scene: awkward
# thought
BOSS stares at you like you just asked to fly the plane.

# speaker: BOSS
"Cute. Reyana, you'll be presenting. You — take notes. We don't have all day."

-> notetaking

=== notetaking ===
# scene: intro_ignoring
# thought
You sit at the corner of the table, laptop open, typing furiously. No one looks at you.

// Scene 2 — flashcut through the meeting
# scene: intro_ignoring
# thought
The meeting flashes forward. Reyana presents. You take notes.

// Ghost choices: options he can see and cannot take. inkjs has no disabled
// choice, so the text ships as a tag and SceneRenderer draws them greyed and
// unclickable, then advances on its own after four seconds. No tap.
// The pipe is escaped because ink reserves | as its alternative separator; it
// survives into the tag value intact.
# scene: staring
# thought
She gets a detail wrong. It's your detail — the one you were still fixing at two in the morning.

# scene: intro_ignoring
# ghost_choices: "That's not quite it — the retry cost is upfront, not per call."\|"Happy to take this bit. It's my slide."
# thought
Both hands on the keyboard. The next sentence has already started and you are three words behind.

~ composure = composure - 2

The meeting starts to wrap up. The team is talking casually now.

# scene: intro_ignoring
# speaker: BOSS
"Anyone have any lunch suggestions?"

# thought
This is my chance!

* [Suggest a lunch idea]
    -> lunch_suggestion

=== lunch_suggestion ===
"How about we grab some sonion rings??"

# scene: awkward
# thought
The room goes quiet. Everyone stares at you, straight-faced. You are ignored.

# speaker: Reyana
"Hey, BOSS... how about we grab those onion rings you like?"

# scene: callout
# speaker: Reyana
"Or should I say... sonoin rings!"

# scene: laughing
# thought
The whole room erupts in laughter.

~ composure = composure - 2

# scene: meme
# thought
Just once in my life, I'd like to go an entire day without having a bruh moment.

-> END