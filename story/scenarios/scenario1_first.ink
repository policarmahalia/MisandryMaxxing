// Stat grammar, consistent across all five chapters:
//   deflecting / laughing along  -> standing up,   composure down
//   naming it                    -> standing down, composure up
//   silence                      -> composure down hardest
// Day one, so the numbers are small. This is the chapter that teaches the bar.
VAR standing = 0
VAR composure = 0

VAR corrected = false
VAR pushed_back = false

// Scene 1
# scene: intro
# speaker: Mahalia
"Hey, I didn't know we had a new marketing hire."

# thought
You're confused why they'd think that.

* ["I'm a Software Engineer, actually..."]
    ~ composure = composure - 1
    ~ corrected = true
    -> scene2
* ["No, I'm the Software Engineer you guys hired?"]
    ~ standing = standing - 1
    ~ composure = composure + 1
    ~ corrected = false
    -> scene2

// Scene 2
=== scene2 ===
{corrected:
    # scene: surprised
    # speaker: Mahalia
    "Oh, that's cute."
- else:
    # scene: shocked
    # speaker: Mahalia
    "Oh! You're serious?"
}

# scene: sideeyeing
# thought
Mahalia gives you a slow once-over.

# scene: checking
# speaker: Mahalia
"Well, don't you think that shirt is a bit too tight for an engineer?"

# thought
You're appalled.

* [Laugh it off]
    ~ standing = standing + 1
    ~ composure = composure - 2
    ~ pushed_back = false
    -> scene3
* ["What's wrong with my shirt?"]
    ~ standing = standing - 1
    ~ composure = composure + 1
    ~ pushed_back = true
    -> scene3

// Scene 3
=== scene3 ===
# scene: pointing
# speaker: Mahalia
"Does your girlfriend know you dress like that for work?"

# thought
You're uncomfortable. Why would they assume you have a girlfriend?

* ["I don't have a girlfriend..."]
    ~ composure = composure - 2
    -> ending
* ["This is really inappropriate."]
    ~ standing = standing - 2
    ~ composure = composure + 1
    -> ending

=== ending ===
# scene: judgemental
# speaker: Mahalia
"Whatever. We're just joking, lighten up...."

~ composure = composure - 1

-> END