// Scenario 4 — Thursday
// Working title: "Informally"
//
// Register: dry, underplayed, short. Consistent with Wednesday. Nobody leers,
// including the prose.
// Thesis: the thing that happens to him is survivable. The thing that happens
// afterwards is what costs him.
//
// LOCKED:
//   - BOSS is a principal engineer, two levels up. Making her a woman is what
//     keeps the mirror on in the one scene that most needs it.
//   - Closed room, two-hander, no audience. The bystander problem lands the
//     next day instead, with the people who already knew.
//   - Verbal, plus a hand that doesn't move when he asks. That's the ceiling.
//   - Reporting is the player's call and both routes fail differently. Neither
//     is marked correct.

VAR standing = 0
VAR composure = 0

// Carried from Wednesday once cross-scenario state exists. kept_receipts is
// read below and pays off by not helping.
VAR kept_receipts = false

VAR named_it = false
VAR froze = false
VAR deflected = false
VAR left_room = false
VAR reported = false


// ============================================================
// Content warning
// ============================================================

# cw: sexual_harassment
# background: black
This scenario contains workplace sexual harassment, including unwanted physical contact.

* [Continue]
    -> sc1_late

* [Skip this scenario]
    -> sc4_skip


// The skip has to advance state or Scenario 5's calibration breaks. Neutral
// defaults: he was there, it cost him, he didn't name it.
=== sc4_skip ===

# background: black
Thursday: a senior colleague harasses him in a closed room after hours. He has to decide whether to report it. Either way, it doesn't resolve in his favour.

~ composure = composure - 2
~ froze = true

-> sc3_dei


// ============================================================
// Scene 1 — The Late One
// ============================================================
=== sc1_late ===

# background: meeting_room_night
# thought
19:50. The floor's empty. BOSS wanted to close out the migration scope before tomorrow, and BOSS is two levels above you, so here you are.

# background: meeting_room_night
# thought
She pushes the door shut with her foot. It's not a gesture. The corridor light is on a sensor and it's been flicking on and off for an hour.

# character: boss, relaxed, right
# speaker: BOSS
"This is good work. I mean it."

# character: boss, relaxed, right
# speaker: BOSS
"For a diversity hire, you've done all right."

# background: meeting_room_night
# thought
She smiles when she says it, so it can be a joke if you need it to be.

# character: boss, relaxed, right
# speaker: BOSS
"Question. How far above and beyond are you actually willing to go for me?"

* ["That depends what you're asking."]
    ~ standing = standing + 1
    ~ composure = composure - 1
    # character: boss, relaxed, right
    # speaker: BOSS
    "Relax. God."
    # background: meeting_room_night
    # thought
    She laughs.
    -> sc2_hand

* [Say nothing. Wait for it to be something else.]
    ~ composure = composure - 2
    ~ froze = true
    # background: meeting_room_night
    # thought
    She lets the silence run and doesn't fill it.
    -> sc2_hand

* ["Whatever it takes, boss."]
    ~ standing = standing + 1
    ~ composure = composure - 2
    ~ deflected = true
    # background: meeting_room_night
    # thought
    It works. She likes it. That's the problem with it.
    -> sc2_hand

* ["Let's just finish the scope."]
    ~ composure = composure - 1
    # character: boss, relaxed, right
    # speaker: BOSS
    "Sure."
    # background: meeting_room_night
    # thought
    She doesn't move.
    -> sc2_hand


// ============================================================
// Scene 2 — The Hand
// None of these is the right one.
// ============================================================
=== sc2_hand ===

# background: meeting_room_night
# character: boss, close, right
# thought
She reaches over for the printout on your side of the table, and when she straightens up her hand stays on your shoulder.

# character: boss, close, right
# speaker: BOSS
"I'm just trying to work out how you got this one. Are you somebody's nephew?"

# background: meeting_room_night
# thought
Her hand hasn't moved.

# character: boss, close, right
# speaker: BOSS
"Or did you sleep with Delia?"

* ["Can you take your hand off me."]
    ~ standing = standing - 1
    ~ composure = composure + 1
    ~ named_it = true
    # background: meeting_room_night
    # thought
    She does, immediately, and holds both palms up.
    # character: boss, close, right
    # speaker: BOSS
    "Wow. Okay."
    # character: boss, close, right
    # speaker: BOSS
    "It was a joke. You really can't take one."
    # background: meeting_room_night
    # thought
    She is embarrassed, and the embarrassment converts into something cooler within about four seconds.
    -> sc2_out

* [Don't move. Wait for her to.]
    ~ composure = composure - 3
    ~ froze = true
    # background: meeting_room_night
    # thought
    It's about eleven seconds. You count them afterwards, in the car park, and eleven doesn't sound like very long.
    -> sc2_out

* ["Ha — you got me. Delia's a monster in the sack."]
    ~ standing = standing + 2
    ~ composure = composure - 3
    ~ deflected = true
    # background: meeting_room_night
    # thought
    She laughs properly, takes her hand back, and the room is easy again.
    # background: meeting_room_night
    # thought
    It worked. It's the move that works every time, and every time it costs the same.
    -> sc2_out

* [Stand up. Get your laptop. Leave.]
    ~ standing = standing - 2
    ~ composure = composure + 1
    ~ left_room = true
    # character: boss, relaxed, right
    # speaker: BOSS
    "We're not done?"
    # background: meeting_room_night
    # thought
    Behind you, and genuinely puzzled.
    -> sc2_out


=== sc2_out ===

# character: boss, relaxed, right
# speaker: BOSS
"Don't worry. I don't kiss and tell."

# background: meeting_room_night
# thought
She's already back on her laptop. The scope doc gets finished at 20:40 and it's fine. It's good, actually.

-> sc3_dei


// ============================================================
// Scene 3 — The Page
// Its own scene on purpose. It's the thesis of the whole game, and it should
// not be something someone else shows him.
// ============================================================
=== sc3_dei ===

# background: home_evening
# thought
22:10. You're looking for the parental leave policy and the careers site loads instead.

# background: home_evening
# thought
Building a More Inclusive Future.

# background: home_evening
# thought
You're the third photo. Blue shirt, the one from your second week. Someone has cropped it well.

# background: home_evening
# thought
You don't remember being asked.

~ composure = composure - 1

-> sc4_report


// ============================================================
// Scene 4 — Friday Morning
// ============================================================
=== sc4_report ===

# background: openplan_morning
# thought
Vanna from People and Culture has open office hours until eleven. You know this because it's in the footer of every email.

* [Go to Vanna.]
    ~ reported = true
    -> sc4_pc

* [Don't.]
    -> sc4_noreport


// ---- Reporting ----
=== sc4_pc ===

# background: small_room
# character: vanna, kind, centre
# thought
Vanna is kind about it. That's not a subversion. She is actually, genuinely kind, and she listens all the way to the end without checking her phone.

# character: vanna, kind, centre
# speaker: Vanna
"Thank you for telling me. That took something."

# character: vanna, kind, centre
# speaker: Vanna
"So — I want to lay out the options, because you get to choose. There's a formal process, which means a written complaint, an investigation, and BOSS's told it's her. Or we handle it informally, which means I have a conversation with her and it stays off the record."

# character: vanna, kind, centre
# speaker: Vanna
"I'll be straight with you: formal is a long road, and you'd be working alongside her the whole way."

// Wednesday's payoff. It fires, and it pays off by not helping.
{kept_receipts:
    # background: small_room
    # thought
    You mention the report, and the file history, and that this is the second thing this month.
    # character: vanna, kind, centre
    # speaker: Vanna
    "That's a separate matter, and honestly a different process. Let's not tangle them."
    # background: small_room
    # thought
    She writes it down anyway, on the same page.
}

* ["Formal."]
    ~ standing = standing - 2
    ~ composure = composure + 1
    # background: small_room
    # thought
    It takes six weeks. The finding is that the conduct was "capable of being perceived as inappropriate" and that both parties would benefit from refreshed training.
    # background: small_room
    # thought
    BOSS does the module. So do you.
    # background: small_room
    # thought
    The outcome letter is two paragraphs and one of them is about confidentiality.
    -> sc4_converge

* ["Informal, I guess."]
    ~ composure = composure - 2
    # character: vanna, kind, centre
    # speaker: Vanna
    "I think that's wise."
    # background: small_room
    # thought
    She has the conversation. BOSS is scrupulously professional with you from then on, in a way that is visible to everyone and gets read, by everyone, as something happened there.
    -> sc4_converge

* ["Actually — forget it. Sorry."]
    ~ composure = composure - 2
    # character: vanna, kind, centre
    # speaker: Vanna
    "The door's open whenever."
    # background: small_room
    # thought
    She means it. It stays open. You don't come back.
    -> sc4_converge


// ---- Not reporting ----
=== sc4_noreport ===

# background: kitchenette
# thought
You don't go. At 10:30 BOSS says good morning like a person who says good morning.

~ composure = composure - 2

-> sc4_converge


// ============================================================
=== sc4_converge ===

// Jean's beat plays on every route. It used to sit inside sc4_noreport, which
// meant anyone who reported never learned that the floor already knew — and
// quiz4 asks about this exact line.
# background: kitchenette
# thought
Later, at the sink, Jean brings it up herself. You hadn't mentioned it to anyone.

# background: kitchenette
# speaker: Jean
"You were here late with BOSS, yeah? She's a lot after seven."

# background: kitchenette
# speaker: Jean
"You get used to her."

# background: kitchenette
# thought
You get used to her. Which means Jean already has. Which means Jean knew before yesterday, and so, presumably, did whoever told Jean.

// Thursday is now the last chapter, so this is the game's ending. It closes on
// no resolution on any route: reporting formally, informally, withdrawing, or
// not going at all all arrive here.
# background: openplan_morning
# thought
Friday, 15:00. The scope goes into the sprint with your name on it as author and hers as reviewer.

# background: openplan_morning
# thought
Nothing about the floor is different in the morning. She says good morning. You say it back.

# background: openplan_morning
# thought
You are going to work here on Monday, and so is she.

# module: quiz4

-> END
