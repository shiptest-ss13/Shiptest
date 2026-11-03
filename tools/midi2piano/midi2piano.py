"""
This module allows user to convert MIDI melodies to SS13 sheet music ready
for copy-and-paste
"""
from bisect import bisect_right
from collections import Counter
from dataclasses import dataclass, field, replace
import copy
import math
import tkinter as tk
from tkinter import filedialog, messagebox
import midi as mi
import pyperclip as pclip

LINE_LENGTH_LIM = 300
LINES_LIMIT = 1000
TICK_LAG = 0.5
OVERALL_IMPORT_LIM = LINE_LENGTH_LIM*LINES_LIMIT
END_OF_LINE_CHAR = """
""" # BYOND can't parse \n and I am forced to define my own NEWLINE char

OCTAVE_TRANSPOSE = 0 # Change here to transpose melodies by octaves
FLOAT_PRECISION = 2 # Change here to allow more or less numbers after dot in floats

OCTAVE_KEYS = 12
HIGHEST_OCTAVE = 9

time_quanta = 100 * TICK_LAG
TIMING_TOLERANCE = time_quanta / 2 # Chord timing drifts at most this many ms from the MIDI before a /x corrects it
EVEN_PULSE_MAX_SPEEDUP = 0.12 # Speed the song up by up to this much (0.12 is 12%) if it puts its most common gap between notes on whole ticks. 0 never speeds it up
EVEN_PULSE_MAX_SLOWDOWN = 0.15 # Same for slowing it down. 0 never slows it down
CHORD_WINDOW = 40 # Notes starting within this many ms of a chord's first note join it
MIN_HOLD = 250 # Min length in ms for a note to be held, shorter ones just fade out over SUSTAIN
SUSTAIN = "linear 1" # How notes fade once released, "linear <seconds>" or "exponential <factor>"
HOLD_LAST_NOTE = False # Whether the game holds the last played note until the next one. Off by default, as notes have their own holds
VOLUME_LEVELS = 8 # Note velocities are rounded to this many volume levels, so volume changes less often

# The midi library's score events are lists, the ones we use being
# ['note', start, duration, channel, note number, velocity] and
# ['control_change', time, channel, controller, value], times in ms once converted.
# After filtering, notes become Note and are grouped into Chord.
@dataclass
class Note:
    """
    A note to play, times in milliseconds
    """
    start: float
    num: int # MIDI note number, 60 is middle C
    duration: float
    volume: int # Percentage
    gap: float = 0 # Time until the next note starts, 0 if it's in the same chord. Set by convert_into_gaps

@dataclass
class Chord:
    """
    Notes played together, and how long until the next chord
    """
    notes: list = field(default_factory=list)
    duration: float = 0

# UTILITY FUNCTIONS
def condition(event):
    """
    This function check if given MIDI event is meaningful
    """
    if event[0] != 'note':
        return False
    channel = event[3]
    if channel == 9: # Percussion, MIDI channel 10
        return False
    return True

def notenum2string(num, accidentals, octaves):
    """
    This function converts given notenum to SS13 note according to previous
    runs expressed using _accidentals_ and _octaves_
    """
    names = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    convert_table = {1:0, 3:1, 6:2, 8:3, 10:4}
    inclusion_table = {0:0, 2:1, 5:2, 7:3, 9:4}
    correspondence_table = {0:1, 1:0, 2:3, 3:2, 5:6, 6:5, 7:8, 8:7, 9:10, 10:9}

    num += OCTAVE_KEYS * OCTAVE_TRANSPOSE
    octave = int(num / OCTAVE_KEYS)
    if octave < 1 or octave > HIGHEST_OCTAVE:
        return ["", accidentals, octaves]

    accidentals = accidentals.copy()
    octaves = octaves.copy()

    output_octaves = list(octaves)
    name_indx = num % OCTAVE_KEYS

    accidental = (len(names[name_indx]) == 2)
    output_octaves[name_indx] = octave
    if name_indx in correspondence_table:
        output_octaves[correspondence_table[name_indx]] = octave
    add_n = False

    if accidental:
        accidentals[convert_table[name_indx]] = True
    else:
        if name_indx in inclusion_table:
            add_n = accidentals[inclusion_table[name_indx]]
            accidentals[inclusion_table[name_indx]] = False

    return [
        (
            names[name_indx]+
            ("n" if add_n else "")+
            str((octave if octave != octaves[name_indx] else ""))
        ),
        accidentals,
        output_octaves
        ]

def dur2mod(dur, bpm_mod=1.0):
    """
    This functions returns float representation of duration ready to be
    added to the note after /
    """
    mod = bpm_mod / dur
    decimals = max(FLOAT_PRECISION, 2 - math.floor(math.log10(mod)))
    return f"{mod:.{decimals}f}".rstrip('0').rstrip('.')

def velocity2volume(velocity):
    """
    Converts MIDI note velocity to a volume percentage,
    rounded to one of VOLUME_LEVELS levels
    """
    level = max(1, round(velocity / 127 * VOLUME_LEVELS))
    return round(level * 100 / VOLUME_LEVELS)

def dur2hold(dur, bpm_mod=1.0):
    """
    Returns float representation of how many beats a note
    is held for, ready to be added to the note after ~
    """
    hold = dur / bpm_mod
    hold = round(hold, FLOAT_PRECISION)
    return str(hold).rstrip('0').rstrip('.')
# END OF UTILITY FUNCTIONS

# CONVERSION FUNCTIONS
def obtain_midi_file(root):
    """
    Asks user to select MIDI and returns this file opened in binary mode for reading
    """
    file = filedialog.askopenfilename(parent=root,
                                      title='Choose MIDI file to convert',
                                      filetypes=[('MIDI files', '*.mid *.midi'), ('All files', '*.*')])
    if not file:
        return None
    with open(file, mode='rb') as midi_file:
        return midi_file.read()

def delta_ticks_to_millisecs(opus):
    """
    Recalibrates an opus from the midi library to one tick per millisecond.
    Unlike midi.to_milliseconds, this changes tempo for every track instead
    of only the main track.
    """
    ticks_per_beat = int(opus[0])
    tempo_changes = [] # [absolute tick, microseconds per beat]
    for track in opus[1:]:
        tick = 0
        for event in track:
            tick += event[1]
            if event[0] == 'set_tempo':
                tempo_changes.append([tick, event[2]])
    tempo_changes.sort(key=lambda change: change[0])
    # [absolute tick, milliseconds at that tick, milliseconds per tick from there]
    tempo_map = [[0, 0.0, 500000 / 1000 / ticks_per_beat]]
    for tick, tempo in tempo_changes:
        last_tick, last_ms, last_rate = tempo_map[-1]
        tempo_map.append([tick, last_ms + (tick - last_tick) * last_rate, tempo / 1000 / ticks_per_beat])
    map_ticks = [entry[0] for entry in tempo_map]

    def tick2ms(tick):
        map_tick, map_ms, rate = tempo_map[bisect_right(map_ticks, tick) - 1]
        return map_ms + (tick - map_tick) * rate

    new_opus = [1000]
    for track in opus[1:]:
        new_track = [['set_tempo', 0, 1000000]]
        tick = 0
        previous_ms = 0
        for event in track:
            tick += event[1]
            if event[0] == 'set_tempo':
                continue
            ms = round(tick2ms(tick))
            new_event = copy.deepcopy(event)
            new_event[1] = ms - previous_ms
            previous_ms = ms
            new_track.append(new_event)
        new_opus.append(new_track)
    return new_opus

def midi2score_without_ticks(midi_file):
    """
    Transforms aforementioned file into a score, truncates it and returns it
    """
    opus = mi.midi2opus(midi_file)
    opus = delta_ticks_to_millisecs(opus)
    score = mi.opus2score(opus)
    return score[1:] # Ticks don't matter anymore, it is always 1000

def apply_sustain_pedal(score):
    """
    Lengthens notes released while the sustain pedal (controller 64) is down
    until the pedal comes up, or the same note is played again, and returns new score
    """
    pedal_events = sorted(
        [event for score_track in score for event in score_track
         if event[0] == 'control_change' and event[3] == 64],
        key=lambda event: event[1])
    # channel is list of [pedal down time, pedal up time]
    pedal_intervals = {}
    pedal_down = {}
    for _, time, channel, _, value in pedal_events:
        if value >= 64:
            pedal_down.setdefault(channel, time)
        elif channel in pedal_down:
            pedal_intervals.setdefault(channel, []).append([pedal_down.pop(channel), time])
    for channel, down_time in pedal_down.items(): # Never released
        pedal_intervals.setdefault(channel, []).append([down_time, float('inf')])
    if not pedal_intervals:
        return score

    new_score = [[list(event) for event in score_track] for score_track in score]
    notes = [event for score_track in new_score for event in score_track if event[0] == 'note']
    # (channel, note) -> start times, so a pedalled note stops when it is played again
    next_starts = {}
    for _, start, _, channel, num, _ in notes:
        next_starts.setdefault((channel, num), []).append(start)
    for starts in next_starts.values():
        starts.sort()
    for event in notes:
        _, start, duration, channel, num, _ = event
        end = start + duration
        pedal_end = end
        for down_time, up_time in pedal_intervals.get(channel, []):
            if down_time <= end < up_time:
                pedal_end = up_time
                break
        if pedal_end == end:
            continue
        for next_start in next_starts[(channel, num)]:
            if next_start > start:
                pedal_end = min(pedal_end, next_start)
                break
        if pedal_end != float('inf'):
            event[2] = max(duration, pedal_end - start)
    return new_score

def filter_events_from_score(score):
    """
    Filters out irrevelant events and returns new score
    """
    return list(map( # For each score track
        lambda score_track: list(filter( # Filter irrevelant events
            condition,
            score_track
            )),
        score
        ))

def filter_empty_tracks(score):
    """
    Filters out empty tracks and returns new score
    """
    return list(filter(
        lambda score_track: score_track,
        score))


def score_to_notes(score):
    """
    Recreates score with a Note for each note event and returns new score
    """
    return list(map(
        lambda score_track: list(map(
            lambda event: Note(start=event[1], num=event[4], duration=event[2], volume=velocity2volume(event[5])),
            score_track)),
        score))

def merge_events(score):
    """Merges all tracks together and returns new score"""
    return [note for score_track in score for note in score_track]

def sort_score_by_event_times(score):
    """Sorts events by start time and returns new score"""
    return sorted(score, key=lambda note: note.start)

def convert_into_gaps(score):
    """
    Sets each note's gap to the time until the next note starts and returns new score
    """
    return list(map(
        lambda super_event: replace(super_event[0], gap=super_event[1].start - super_event[0].start),
        zip(score[:-1], score[1:]) # Shifted association. [1, 2, 3] -> [ (1, 2), (2, 3) ]
        ))+[replace(score[-1], gap=1000)] # Add 1 second note to the end

def snap_chords(score):
    """
    Moves notes that start within CHORD_WINDOW of a chord's first note onto it
    """
    new_score = []
    chord_start = None
    for note in score:
        if chord_start is None or note.start - chord_start >= CHORD_WINDOW:
            chord_start = note.start
        new_score.append(replace(note, start=chord_start))
    return new_score

def find_even_pulse_scale(score):
    """
    Returns how much to rescale the song's timing so its most common gap between
    notes is a whole number of ticks, or 1 if it would exceed EVEN_PULSE_MAX_SPEEDUP
    or EVEN_PULSE_MAX_SLOWDOWN, so we don't scale it
    """
    starts = sorted({note.start for note in score})
    gaps = [later - earlier for earlier, later in zip(starts[:-1], starts[1:]) if later - earlier >= time_quanta / 2]
    if not gaps:
        return 1.0
    common_gap = max(set(round(gap) for gap in gaps), key=lambda gap: sum(abs(other - gap) <= gap * 0.03 for other in gaps))
    close_gaps = [gap for gap in gaps if abs(gap - common_gap) <= common_gap * 0.03]
    common_gap = sum(close_gaps) / len(close_gaps)
    scales = [ticks * time_quanta / common_gap for ticks in {max(1, math.floor(common_gap / time_quanta)), math.ceil(common_gap / time_quanta)}]
    scales = [scale for scale in scales if 1 - EVEN_PULSE_MAX_SPEEDUP <= scale <= 1 + EVEN_PULSE_MAX_SLOWDOWN]
    if not scales:
        return 1.0
    scale = min(scales, key=lambda scale: abs(scale - 1))
    if abs(scale - 1) < 0.001:
        return 1.0
    return scale

def scale_score_times(score, scale):
    """
    Stretches every note's start and length by scale and returns new score
    """
    return list(map(
        lambda note: replace(note, start=note.start * scale, duration=note.duration * scale),
        score))

def perform_roundation(score):
    """
    Rounds start times to the nearest multiple of time quanta as BYOND can't
    process duration less than that and returns new score.
    """
    return list(map(
        lambda note: replace(note, start=time_quanta*round(note.start/time_quanta)),
        score))

def merge_duplicate_notes(score):
    """
    Merges notes of the same pitch starting at the same time, such as from
    two tracks doubling each other, keeping the longest and loudest, and returns new score
    """
    merged = {}
    for note in score:
        key = (note.start, note.num)
        if key in merged:
            merged[key].duration = max(merged[key].duration, note.duration)
            merged[key].volume = max(merged[key].volume, note.volume)
        else:
            merged[key] = replace(note)
    return list(merged.values()) # Dicts keep insertion order, so still sorted

def obtain_common_duration(score):
    """
    Returns the most frequent duration throughout the whole melody
    """
    # Gaps between chords, leaving out the 0s between notes in the same chord.
    # On a tie, most_common returns the one found first
    return Counter(note.gap for note in score if note.gap).most_common(1)[0][0]

def reduce_score_to_chords(score):
    """
    Groups notes into chords, each lasting until the next, and returns them
    """
    new_score = []
    new_chord = Chord()
    for note in score:
        new_chord.notes.append(note) # Append new note to the chord
        if note.gap == 0:
            continue # Add new notes to the chord until non-zero duration is hit
        new_chord.duration = note.gap # This is the duration of chord
        new_score.append(new_chord) # Append chord to the list
        new_chord = Chord() # Reset the chord
    return new_score

def obtain_sheet_music(score, most_frequent_dur):
    """
    Returns unformated sheet music from score
    """
    result = ""

    octaves = [3 for i in range(12)]
    accidentals = [False for i in range(7)]
    current_volume = 100 # Volume is remembered between notes, starting at full
    # When each chord should end according to the MIDI, and when it will in game.
    target_time = 0
    sheet_time = 0
    for chord in score:
        # Play notes at the current volume first, then group the rest by volume, so it changes as little as possible
        chord.notes.sort(key=lambda note: (note.volume != current_volume, note.volume))
        for note_indx, note in enumerate(chord.notes):
            data = notenum2string(note.num, accidentals, octaves)
            result += data[0]
            accidentals = data[1]
            octaves = data[2]
            if data[0] and note.volume != current_volume:
                result += '!'
                result += str(note.volume)
                current_volume = note.volume
            if data[0] and note.duration >= MIN_HOLD:
                result += '~'
                result += dur2hold(note.duration, most_frequent_dur)
            if note_indx != len(chord.notes)-1:
                result += '-'

        target_time += chord.duration
        wanted_dur = max(target_time - sheet_time, time_quanta) # At least a tick
        if abs(wanted_dur - most_frequent_dur) <= TIMING_TOLERANCE:
            sheet_time += most_frequent_dur
        else:
            mod = dur2mod(wanted_dur, most_frequent_dur)
            result += '/'
            result += mod
            sheet_time += max(most_frequent_dur / float(mod), time_quanta)
        result += ','

    return result

def explode_sheet_music(sheet_music):
    """
    Splits unformatted sheet music into formated lines of LINE_LEN_LIM
    and such and returns a list of such lines, and whether it had to
    leave the end out to fit in LINES_LIMIT
    """
    split_music = sheet_music.split(',')
    split_music = list(map(lambda note: note+',', split_music))
    split_list = []
    counter = 0
    line_counter = 1
    for note in split_music:
        if counter+len(note) > LINE_LENGTH_LIM-2:
            if line_counter >= LINES_LIMIT:
                return split_list, True
            split_list[-1] = split_list[-1].rstrip(',')
            split_list[-1] += END_OF_LINE_CHAR
            counter = 0
            line_counter += 1
        split_list.append(note)
        counter += len(note)

    return split_list, False

def finalize_sheet_music(split_music, most_frequent_dur):
    """
    Recreates sheet music from exploded sheet music, truncates it and returns it
    """
    sheet_music = ""
    for note in split_music:
        sheet_music += note
    sheet_music = sheet_music.rstrip(',') # Trim the last ,
    sheet_music = (
        "BPM: " + str(round(60000 / most_frequent_dur)) + END_OF_LINE_CHAR +
        "SUSTAIN: " + SUSTAIN + END_OF_LINE_CHAR +
        "HOLDLAST: " + ("on" if HOLD_LAST_NOTE else "off") + END_OF_LINE_CHAR +
        sheet_music)
    return sheet_music[:min(len(sheet_music), OVERALL_IMPORT_LIM)]

def read_notes(midi_file):
    """
    Returns every note in the MIDI file to play, sorted and snapped into chords,
    or an empty list if there aren't any
    """
    score = midi2score_without_ticks(midi_file)
    score = apply_sustain_pedal(score)
    score = filter_events_from_score(score)
    score = score_to_notes(score)
    score = filter_empty_tracks(score)
    if not score:
        return []
    score = merge_events(score)
    score = sort_score_by_event_times(score)
    return snap_chords(score)

def convert(score, pulse_scale):
    """
    Converts notes from read_notes into sheet music, with its timing scaled by pulse_scale.
    Returns the sheet music, and whether its end was left out to fit in LINES_LIMIT
    """
    score = scale_score_times(score, pulse_scale)
    score = perform_roundation(score)
    score = merge_duplicate_notes(score)
    score = convert_into_gaps(score)
    most_frequent_dur = obtain_common_duration(score)
    score = reduce_score_to_chords(score)
    sheet_music = obtain_sheet_music(score, most_frequent_dur)
    split_music, truncated = explode_sheet_music(sheet_music)
    return finalize_sheet_music(split_music, most_frequent_dur), truncated
# END OF CONVERSION FUNCTIONS

def describe_tempo_change(pulse_scale):
    """
    Describes a tempo change from find_even_pulse_scale
    """
    tempo_change = abs(1 / pulse_scale - 1) * 100
    tempo_amount = f"{round(tempo_change)}%" if tempo_change >= 1 else "slightly"
    return f"{tempo_amount} {'faster' if pulse_scale < 1 else 'slower'}"

def main_cycle():
    """
    Activate the script
    """
    root = tk.Tk()
    root.withdraw()
    root.attributes('-topmost', True)
    while True:
        midi_file = obtain_midi_file(root)
        if not midi_file:
            root.destroy()
            return # Cancel
        try:
            score = read_notes(midi_file)
            if not score:
                messagebox.showwarning('Nothing to convert',
                                       'No notes found in this file. It may not be a MIDI file, or only have drums.',
                                       parent=root)
                continue
            pulse_scale = find_even_pulse_scale(score)
            if pulse_scale != 1 and not messagebox.askyesno(
                    'Change tempo?',
                    f"This song's fast notes don't fit the game's {time_quanta:g} ms ticks, so they'd play unevenly.\n\n"
                    f"Yes: play it {describe_tempo_change(pulse_scale)} than the MIDI so they play evenly.\n"
                    "No: keep the exact tempo, with slightly uneven timing.",
                    parent=root):
                pulse_scale = 1.0
            sheet_music, truncated = convert(score, pulse_scale)
        except Exception as error:
            messagebox.showerror('Conversion failed', f"Couldn't convert this file: {error!r}", parent=root)
            continue

        pclip.copy(sheet_music)
        tempo_note = ''
        if pulse_scale != 1:
            tempo_note = f" Played {describe_tempo_change(pulse_scale)} than the source MIDI so notes play evenly."
        truncated_note = ''
        if truncated:
            truncated_note = f"\n\nThe song was too long, truncated to {LINES_LIMIT} lines."
        messagebox.showinfo('Converted',
                            f"Copied {sheet_music.count(END_OF_LINE_CHAR) + 1} lines to the clipboard, ready to import.{tempo_note}{truncated_note}",
                            parent=root)

if __name__ == '__main__':
    main_cycle()
