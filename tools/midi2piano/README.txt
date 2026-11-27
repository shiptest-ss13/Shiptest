This is a remake of 2013 midi2piano tool. Further expanded in 2026! Wow!

Requirements:
  Python 3

Simply run midi2piano.py and choose midi file you want to convert.
The "sheet music" will be copied to the clipboard, and a message will say so, or why a file couldn't be converted.

There are some constants defined at the top of midi2piano.py.

TICK_LAG - CHANGE THIS VALUE TO TICK LAG OF YOUR SERVER!

Change their value if needed.

LINE_LENGTH_LIM - max length of line allowed in the sheet music
LINES_LIMIT - max amount of lines allowed in the sheet music. Extra lines will be cropped.

OVERALL_IMPORT_LIM - max amount of characters allowed in the sheet music.
TIMING_TOLERANCE - how far, in ms, chord timing may drift from the MIDI before a /x is picked to correct it. /x values are rounded, so each one makes up for the error so far.
EVEN_PULSE_MAX_SPEEDUP, EVEN_PULSE_MAX_SLOWDOWN - notes can only land on ticks (50 ms at TICK_LAG 0.5), so a song whose most common gap between notes isn't a whole number of ticks gets uneven fast runs (110 ms notes come out as 100, 100, 100, 100, 150 ms). If adjusting speed fixes this, you're offered to get it adjusted by x percentage. Set both to 0 to always keep the exact tempo.
CHORD_WINDOW - notes starting within this many ms of a chord's first note are played as part of that chord.
MIN_HOLD - notes at least this many ms long get a ~x hold for their length. Shorter notes just fade out over SUSTAIN, which starts as soon as they play.
SUSTAIN - how notes fade once released, written as a SUSTAIN: line the game reads on import. "linear <seconds>" or "exponential <factor>", same as the instrument's sustain settings.
HOLD_LAST_NOTE - whether the game holds the last played note until the next one, written as a HOLDLAST: line. Off by default, as converted notes have their own ~x holds.
VOLUME_LEVELS - note velocities are rounded to this many volume levels. More levels means more volume changes and longer sheet music.


You can also transpose music if you need to
OCTAVE_TRANSPOSE - amount of octaves you melody will be shifted by
FLOAT_PRECISION - read comment

Additional notes:
1. Unlike previous midi2piano, this tool optimizes sheet music to fit more in less lines.
2. Note start times are rounded to the nearest 50 ms, as that is one tick at TICK_LAG 0.5. Notes within CHORD_WINDOW of each other are chorded first.
3. Percussion (MIDI channel 10) is skipped, as instruments can only play pitched notes.
4. Notes at least MIN_HOLD long are written with a ~x hold, x being their length in beats. Holds are capped at 5 seconds in game.
5. Note velocities are written as !x volume changes, only when the volume changes, as volume is maintained for following notes.
6. The sustain pedal lengthens notes released while it is down, until it comes up or the note is played again.
7. Notes of the same pitch starting together, such as two tracks doubling each other, are merged into one.
8. Tempo changes are followed, wherever they are in the file. The song gets one BPM, with /x on the chords that differ from it.

This tool is considered final.

Made by EditorRUS/Delta Epsilon from Animus Station, ss13.ru
Contact me in Discord if you find any major issues: DeltaEpsilon#7787

Modified by Prodirus
