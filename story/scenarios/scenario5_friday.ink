// Scenario 5 — Friday
// Working title: "Calibration"
//
// Register: dry, underplayed, but this is the one scene allowed to land
// plainly. No irony in the last three minutes.
//
// Thesis: the rumour didn't just embarrass him. It cost him the one person who
// could have helped, and she didn't know that until she said it out loud.
//
// LOCKED:
//   - "Friday" stays the label; the time-skip happens inside the chapter.
//   - Delia's reveal is a realisation, not a confession. She comes in planning
//     to talk about communication style.
//   - Three endings built. Out and Unregistered stay documented, unbuilt.
//   - The gate is earned on screen: backed_owen is set in Scene 3 and is the
//     only route into The One Worth Having.

VAR standing = 0
VAR composure = 0

// Carried from earlier chapters once cross-scenario state exists.
VAR deflected = false
VAR reported = false
VAR named_it = false
VAR note_taker = false

VAR backed_owen = false


// ============================================================
// Scene 1 — Friday, 09:15
// ============================================================

# background: openplan_morning
# thought
There's a new starter on the floor. Backend, junior, started Monday on the other pod.

# background: openplan_morning
# thought
Two people mention it to you before ten. Both of them mention it the same way.

# character: mahalia, cheerful, right
# speaker: Mahalia
"Have you met Sandes? You two should get coffee."

~ composure = composure - 1

-> sc5_ask


// ============================================================
// Scene 2 — The Ask
// ============================================================
=== sc5_ask ===

# background: small_room
# character: delia, warm, centre
# thought
Delia catches you before standup. She's pleased about something.

# character: delia, warm, centre
# speaker: Delia
"Sandes — I'd like you to mentor him. Informally, nothing heavy. You've had a harder ramp than you should have and I think that makes you good at it."

# background: small_room
# thought
It's a compliment. It's also the first time all quarter she's sought you out.

# character: delia, warm, centre
# speaker: Delia
"Also — Culture Club's short a rep and I put your name down. It's an hour a fortnight."

{deflected:
    # character: delia, warm, centre
    # speaker: Delia
    "You're easy to have around. People notice that."
}

* ["Happy to do both."]
    ~ standing = standing + 1
    ~ composure = composure - 2
    # background: small_room
    # thought
    It's four hours a fortnight, not two, and none of it is in your objectives.
    -> sc5_skip_card

* ["Mentoring yes. Culture Club, can I pass?"]
    ~ standing = standing - 1
    ~ composure = composure + 1
    # character: delia, warm, centre
    # speaker: Delia
    "Course."
    # character: delia, warm, centre
    # speaker: Delia
    "I'll ask Marcus."
    # background: small_room
    # thought
    Marcus has done it twice.
    -> sc5_skip_card

* ["Why me for Culture Club?"]
    ~ standing = standing - 1
    ~ composure = composure + 2
    # character: delia, warm, centre
    # speaker: Delia
    "Because—"
    # background: small_room
    # thought
    She stops. She actually stops.
    # character: delia, uncertain, centre
    # speaker: Delia
    "That's a fair question. Let me think about that."
    # background: small_room
    # thought
    She puts your name down anyway, and she does think about it, and that turns out to matter in about eleven weeks.
    -> sc5_skip_card

* [Say yes to everything. Don't ask.]
    ~ standing = standing + 1
    ~ composure = composure - 3
    ~ note_taker = true
    -> sc5_skip_card


// ============================================================
// Scene 3 — Eleven Weeks
// ============================================================
=== sc5_skip_card ===

# background: black
# thought
Eleven weeks.

# background: black
# thought
The settlement migration ships. Twice you ask someone to pair on it and twice they're honest about being busy, and you do it alone, and it's fine, and it takes forty percent longer than it should have.

# background: black
# thought
Your face is still on the careers page.

~ composure = composure - 1

-> sc5_room


// ---- The room. This is the gate. ----
=== sc5_room ===

# background: meeting_room
# character: sandes, eager, left
# thought
Sprint review. Sandes, nine weeks in now, says the thing about the connection pool, and it's right, and it goes past the room like a car going past a bus stop.

# background: meeting_room
# thought
Four minutes. Then Ellie says it back, slightly better.

# character: reyana, neutral, centre
# speaker: Reyana
"Nice one, Ellie."

# background: meeting_room
# thought
Sandes's face does the exact thing you've spent three months learning not to let your face do.

// The good ending sits behind a -2 standing hit on purpose. A player
// optimising for the review will not take it. That's the argument.
* ["That was Sandes's, four minutes ago."]
    ~ standing = standing - 2
    ~ backed_owen = true
    # background: meeting_room
    # thought
    The room does what the room does. Reyana says "sure, sure" and moves on.
    # background: meeting_room
    # thought
    Afterwards, two separate people describe you as a bit intense lately. Sandes doesn't thank you and probably didn't register it clearly enough to.
    -> sc5_calibration

* [Message Sandes privately: "that was yours."]
    ~ composure = composure + 1
    # background: meeting_room
    # thought
    He replies with a thumbs up. It's kind. It costs you nothing and it changes nothing.
    -> sc5_calibration

* [Say nothing.]
    ~ composure = composure - 2
    # background: meeting_room
    # thought
    You know exactly what he's feeling and you don't say anything, and the reason you don't is that you've done the arithmetic on what it costs.
    -> sc5_calibration


// ============================================================
// Scene 4 — Calibration
// ============================================================
=== sc5_calibration ===

# background: small_room
# character: delia, neutral, centre
# thought
Quarter end. Forty minutes, scheduled for thirty.

# background: small_room
# thought
The numbers are good. The migration shipped. Nobody disputes any of it.

# character: delia, neutral, centre
# speaker: Delia
"Delivery's strong. Where it gets complicated is communication style."

# character: delia, neutral, centre
# speaker: Delia
"There's a perception you're — the word that came back twice was prickly. Once was hard to read."

{note_taker:
    # character: delia, neutral, centre
    # speaker: Delia
    "And there's a sense you're not always driving the room. Which surprised me, because you're in every room."
}

{reported:
    # background: small_room
    # thought
    A calendar notification slides in on her second screen. She glances at it and turns the screen away, and you both pretend you didn't see the subject line, which is the outcome of your complaint.
    # background: small_room
    # thought
    Six weeks, and it arrives during this.
    ~ composure = composure - 2
}

* ["Prickly compared to who?"]
    ~ standing = standing - 1
    ~ composure = composure + 1
    # background: small_room
    # thought
    A long pause.
    # character: delia, uncertain, centre
    # speaker: Delia
    "That's — yeah. Okay."
    # background: small_room
    # thought
    She writes something down and it isn't a rebuttal.
    -> sc5_endings

* ["Understood. I'll work on it."]
    ~ standing = standing + 2
    ~ composure = composure - 2
    # background: small_room
    # thought
    She's relieved. The meeting gets easier for both of you immediately.
    -> sc5_endings

* ["Can I say something properly?"]
    ~ composure = composure + 2
    -> sc5_plainly

* [Nod. Let her finish.]
    ~ composure = composure - 2
    -> sc5_endings


// Available regardless of stats. Locking the player out of the one honest
// conversation would be a punishment, not a mechanic — so low composure makes
// it visibly more expensive instead.
=== sc5_plainly ===

{composure <= -6:
    # background: small_room
    # thought
    You start. The marketing thing. The report. The minutes.
    # background: small_room
    # thought
    And then you stop, because it turns out there's a limit to how many of these you can say out loud in a row.
    # character: delia, uncertain, centre
    # speaker: Delia
    "Go on. Please."
    # background: small_room
    # thought
    You go on. It takes longer than it should.
- else:
    # background: small_room
    # thought
    You say it plainly, without heat. The marketing thing. The report. The minutes. The photo you weren't asked about.
    # background: small_room
    # thought
    Not as a complaint. As a list, in order, with dates.
}

# character: delia, uncertain, centre
# speaker: Delia
"I know."

-> sc5_reveal


// ============================================================
// The Reveal
//
// PERFORMANCE NOTE: the whole scene lives or dies on the line she doesn't
// finish. Read it aloud. If she sounds like she came in planning to say it,
// rewrite it. She came in planning to talk about communication style.
// ============================================================
=== sc5_reveal ===

# character: delia, uncertain, centre
# speaker: Delia
"Can I tell you why I did what I did? Because I want to be straight with you and I've never actually said this to anyone."

# character: delia, uncertain, centre
# speaker: Delia
"When the thing went round about how you got the ledger work — I heard it in week six. And the correct move, obviously, is to shut it down. Publicly. Be seen backing you."

# character: delia, uncertain, centre
# speaker: Delia
"And I didn't, because if I'd stood up in front of the floor and defended you, every single person in that room would have decided that confirmed it."

# character: delia, uncertain, centre
# speaker: Delia
"So the smart thing was distance. Give it nothing to feed on. Let it starve."

# background: small_room
# thought
She's still explaining. She thinks she's describing something sensible, because she is.

# character: delia, uncertain, centre
# speaker: Delia
"And it did starve, more or less, and—"

// The beat. The sentence does not finish.
# character: delia, uncertain, centre
# speaker: Delia
"...and you did the whole migration on your own."

# background: small_room
# thought
Silence.

# character: delia, uncertain, centre
# speaker: Delia
"I took the one person who could have said 'he's good, I hired him, that's the end of it' — and I removed her. That was me. I did that."

# character: delia, uncertain, centre
# speaker: Delia
"I thought I was protecting you from it. I was protecting you from me, and you needed me."

{named_it:
    # character: delia, uncertain, centre
    # speaker: Delia
    "And when you came to Vanna in October, I was told, and I stayed out of that too. Same reasoning. God."
}

// She doesn't apologise. An apology would let both of them off early.
# character: delia, uncertain, centre
# speaker: Delia
"I don't know what to do with that. I'm going to have to sit with it."

-> sc5_endings


// ============================================================
// Endings
//
// The draft compared standing > composure. That works inside one chapter and
// breaks the moment state carries in: composure only ever decreases across the
// game while standing oscillates around zero, so the comparison is true
// essentially always and Intact becomes unreachable. Measured: 0 of 32 ungated
// routes reached it at every plausible carried-state value.
//
// Standing is the only axis that goes both ways, so it's the one that can
// discriminate. Ended up better-regarded than you started = you played to the
// room and paid for it. Still self-balancing, still survives re-costing.
// backed_owen overrides both.
// ============================================================
=== sc5_endings ===

{
    - backed_owen:
        -> ending_worth_having
    - standing > 0:
        -> ending_palatable
    - else:
        -> ending_intact
}


=== ending_palatable ===

# background: openplan_morning
# thought
The promotion goes through in January. It's real and you earned it, and the way you earned it was by becoming easy to have around.

# background: openplan_morning
# thought
March. Sandes catches you by the window, embarrassed, and asks how you handle Mahalia — because she said something to him about his shirt and he doesn't know if he's allowed to mind.

# background: openplan_morning
# thought
You hear yourself say it before you've decided to.

# speaker: you
"Ah — just laugh it off, mate. It's not worth it."

# background: openplan_morning
# thought
He looks relieved. That's the worst part. He looks relieved.

-> sc5_last_card


=== ending_intact ===

# background: small_room
# thought
The rating is "meets expectations." The promotion goes to someone else and the reason given is communication style.

# background: small_room
# thought
You named it, in the room, to her face, and she didn't disagree, and nothing about the floor is different in the morning.

# background: small_room
# thought
You're still here. You still recognise yourself.

-> sc5_last_card


=== ending_worth_having ===

# background: kitchenette
# thought
March. Sandes catches you by the window and asks how you handle Mahalia — because she said something about his shirt and he doesn't know if he's allowed to mind.

# speaker: you
"You're allowed to mind."

# speaker: you
"It'll cost you. I'm not going to tell you it won't. But you're allowed to mind, and I'll back you if you say something, and I'll say it first if you want me to."

# background: kitchenette
# thought
He goes quiet for a second, because nobody has said that to him, and — you realise, standing there — nobody said it to you either.

-> sc5_last_card


// ============================================================
// The Last Card
//
// Was a replay of Scenario 2's standup with the genders swapped back. Cut:
// reversing one scene and nothing else asked the player to infer the whole
// framing device from a single beat, and with no swapped art it read as the
// game glitching back to chapter 2. Says it plainly instead.
// ============================================================
=== sc5_last_card ===

# background: black
Nothing here was invented.

# background: black
Every scene you have just played is drawn from documented accounts of women working in engineering and technology.

# background: black
The only thing that was changed was who it happened to.

# module: quiz5

-> END
