import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  Dropdown,
  LabeledList,
  NumberInput,
  Section,
  Stack,
  Tooltip,
} from '../components';
import { Window } from '../layouts';

type Data = {
  // ui_data
  using_instrument: string;
  instrument_ready: BooleanLike;
  legacy: BooleanLike;
  note_shift: number;
  octaves: number;
  sustain_mode: string;
  sustain_linear_duration: number;
  sustain_exponential_dropoff: number;
  volume: number;
  volume_dropoff_threshold: number;
  sustain_indefinitely: BooleanLike;
  playing: BooleanLike;
  repeat: number;
  playing_line: number;
  bpm: number;
  // ui_static_data
  lines: string[];
  can_switch_instrument: BooleanLike;
  possible_instruments: InstrumentData[];
  can_noteshift: BooleanLike;
  note_shift_min: number;
  note_shift_max: number;
  max_repeats: number;
  min_volume: number;
  max_volume: number;
  min_dropoff_volume: number;
  max_sustain_seconds: number;
  min_exponential_dropoff: number;
  max_exponential_dropoff: number;
  max_line_chars: number;
  max_lines: number;
};

type InstrumentData = {
  name: string;
  id: string;
};

const SUSTAIN_MODES = ['Linear', 'Exponential'];

/** A LabeledList label with a dotted underline that shows a tooltip on hover. */
const TooltipLabel = (props: { label: string; tooltip: string }) => {
  const { label, tooltip } = props;
  return (
    <Tooltip content={tooltip}>
      <Box inline style={{ 'border-bottom': '1px dotted' }}>
        {label}:
      </Box>
    </Tooltip>
  );
};

export const InstrumentEditor = (props, context) => {
  return (
    <Window width={750} height={550}>
      <Window.Content scrollable>
        <PlaybackSection />
        <SettingsSection />
        <Collapsible open title="Music Editor" icon="pencil">
          <EditorSection />
        </Collapsible>
        <Collapsible title="Help" icon="question">
          <HelpSection />
        </Collapsible>
      </Window.Content>
    </Window>
  );
};

const PlaybackSection = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { playing, repeat, max_repeats, lines = [] } = data;

  return (
    <Section title="Playback">
      <Stack align="center">
        <Stack.Item>
          <Button
            icon={playing ? 'stop' : 'play'}
            disabled={!lines.length}
            onClick={() => act('play_music')}
          >
            {playing ? 'Stop' : 'Play'}
          </Button>
        </Stack.Item>
        <Stack.Item>{playing ? 'Repeats left:' : 'Repeat song:'}</Stack.Item>
        <Stack.Item>
          <NumberInput
            width="45px"
            step={1}
            stepPixelSize={10}
            minValue={0}
            maxValue={max_repeats}
            value={repeat}
            disabled={!!playing}
            onChange={(e, value) => act('set_repeat_amount', { amount: value })}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const SettingsSection = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    using_instrument,
    instrument_ready,
    legacy,
    can_switch_instrument,
    possible_instruments = [],
    can_noteshift,
    note_shift,
    note_shift_min,
    note_shift_max,
    octaves,
    sustain_mode,
    sustain_linear_duration,
    sustain_exponential_dropoff,
    max_sustain_seconds,
    min_exponential_dropoff,
    max_exponential_dropoff,
    volume,
    min_volume,
    max_volume,
    volume_dropoff_threshold,
    min_dropoff_volume,
    sustain_indefinitely,
  } = data;

  return (
    <Section title="Settings">
      <LabeledList>
        <LabeledList.Item label="Instrument">
          {can_switch_instrument ? (
            <Dropdown
              width="100%"
              selected={using_instrument}
              displayText={using_instrument}
              options={possible_instruments.map((instrument) => ({
                displayText: instrument.name,
                value: instrument.id,
              }))}
              onSelected={(value) =>
                act('change_instrument', { new_instrument: value })
              }
            />
          ) : (
            using_instrument
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Status">
          {instrument_ready ? (
            <Box color="good">Ready ({legacy ? 'Legacy' : 'Synthesized'})</Box>
          ) : (
            <Box color="bad">Instrument Definition Error!</Box>
          )}
        </LabeledList.Item>
        <LabeledList.Item label="Volume">
          <NumberInput
            width="60px"
            step={1}
            minValue={min_volume}
            maxValue={max_volume}
            value={volume}
            onChange={(e, value) => act('set_volume', { amount: value })}
          />
        </LabeledList.Item>
        {!!can_noteshift && (
          <LabeledList.Item label="Note Shift">
            <NumberInput
              width="60px"
              step={1}
              stepPixelSize={5}
              minValue={note_shift_min}
              maxValue={note_shift_max}
              value={note_shift}
              onChange={(e, value) => act('set_note_shift', { amount: value })}
            />{' '}
            keys / {octaves} octaves
          </LabeledList.Item>
        )}
        <LabeledList.Item label="Sustain Mode">
          {SUSTAIN_MODES.map((mode) => (
            <Button
              key={mode}
              selected={sustain_mode === mode}
              onClick={() => act('set_sustain_mode', { new_mode: mode })}
            >
              {mode}
            </Button>
          ))}
        </LabeledList.Item>
        {sustain_mode === 'Linear' ? (
          <LabeledList.Item
            label={
              <TooltipLabel
                label="Release"
                tooltip="How long a note takes to fade out after it is played, or after its ~x hold ends."
              />
            }
          >
            <NumberInput
              width="60px"
              step={0.1}
              stepPixelSize={5}
              minValue={0.1}
              maxValue={max_sustain_seconds}
              value={sustain_linear_duration}
              format={(value) => value.toFixed(1)}
              onChange={(e, value) =>
                act('edit_sustain_mode', { amount: value })
              }
            />{' '}
            seconds
          </LabeledList.Item>
        ) : (
          <LabeledList.Item
            label={
              <TooltipLabel
                label="Falloff Factor"
                tooltip="How fast a note fades after it is played, or after its ~x hold ends. Higher is faster."
              />
            }
          >
            <NumberInput
              width="60px"
              step={0.01}
              stepPixelSize={2}
              minValue={min_exponential_dropoff}
              maxValue={max_exponential_dropoff}
              value={sustain_exponential_dropoff}
              format={(value) => value.toFixed(3)}
              onChange={(e, value) =>
                act('edit_sustain_mode', { amount: value })
              }
            />{' '}
            per decisecond
          </LabeledList.Item>
        )}
        <LabeledList.Item
          label={
            <TooltipLabel
              label="Dropoff Threshold"
              tooltip="A fading note stops once its fade reaches this percentage."
            />
          }
        >
          <NumberInput
            width="60px"
            step={1}
            minValue={min_dropoff_volume}
            maxValue={100}
            value={volume_dropoff_threshold}
            onChange={(e, value) =>
              act('set_dropoff_volume', { amount: value })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Last Note">
          <Button.Checkbox
            checked={!!sustain_indefinitely}
            onClick={() => act('toggle_sustain_hold_indefinitely')}
          >
            Hold the last played note until the next one
          </Button.Checkbox>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const EditorSection = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { bpm, lines = [], max_lines, playing_line } = data;

  return (
    <Section>
      <Stack align="center" mb={1}>
        <Stack.Item>
          <Button icon="file" onClick={() => act('start_new_song')}>
            New Song
          </Button>
          <Button icon="file-import" onClick={() => act('import_song')}>
            Import Song
          </Button>
        </Stack.Item>
        <Stack.Item grow />
        <Stack.Item>Tempo:</Stack.Item>
        <Stack.Item>
          <Button
            icon="minus"
            onClick={() => act('tempo', { tempo_change: 'slower' })}
          />
        </Stack.Item>
        <Stack.Item>{bpm} BPM</Stack.Item>
        <Stack.Item>
          <Button
            icon="plus"
            onClick={() => act('tempo', { tempo_change: 'faster' })}
          />
        </Stack.Item>
      </Stack>
      {lines.map((line, index) => (
        <Stack
          key={index}
          align="baseline"
          backgroundColor={
            index + 1 === playing_line ? 'rgba(94, 251, 110, 0.12)' : undefined
          }
        >
          <Stack.Item
            width="70px"
            color={index + 1 === playing_line ? 'good' : 'label'}
          >
            Line {index + 1}:
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="pen"
              tooltip="Edit"
              onClick={() => act('modify_line', { line: index + 1 })}
            />
            <Button
              icon="times"
              color="bad"
              tooltip="Delete"
              onClick={() => act('delete_line', { line: index + 1 })}
            />
          </Stack.Item>
          <Stack.Item grow style={{ 'word-break': 'break-all' }}>
            {line}
          </Stack.Item>
        </Stack>
      ))}
      <Button
        mt={1}
        icon="plus"
        disabled={lines.length >= max_lines}
        onClick={() => act('add_new_line')}
      >
        Add Line
      </Button>
    </Section>
  );
};

const HelpSection = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { max_line_chars, max_lines, max_sustain_seconds } = data;

  return (
    <Section>
      Lines are a series of chords, separated by commas (,), each with notes
      separated by hyphens (-).
      <br />
      Every note in a chord will play together, with chord timed by the tempo.
      <br />
      <br />
      Notes are played by the names of the note, and optionally, the accidental,
      and/or the octave number.
      <br />
      By default, every note is natural and in octave 3. Defining otherwise is
      remembered for each note.
      <br />
      Example: <i>C,D,E,F,G,A,B</i> will play a C major scale.
      <br />
      After a note has an accidental placed, it will be remembered:{' '}
      <i>C,C4,C,C3</i> is <i>C3,C4,C4,C3</i>
      <br />
      Chords can be played simply by seperating each note with a hyphon:{' '}
      <i>A-C#,Cn-E,E-G#,Gn-B</i>
      <br />A pause may be denoted by an empty chord: <i>C,E,,C,G</i>
      <br />
      To make a chord be a different time, end it with /x, where the chord
      length will be length defined by tempo / x: <i>C,G/2,E/4</i>
      <br />
      Combined, an example is: <i>E-E4/4,F#/2,G#/8,B/8,E3-E4/4</i>
      <br />
      <br />
      To hold a note at full volume before it fades, end it with ~x, where x is
      the number of beats to hold it for. Holds last at most{' '}
      {max_sustain_seconds} seconds: <i>C3~4-E4,G4,C5,E5</i>
      <br />
      To change how loud notes are, end a note with !x, where x is a volume from
      1 to 100 percent. It is remembered for every note after it:{' '}
      <i>C!40,D,E,F!100,G</i> plays C to E quietly.
      <br />A note can have both, in either order: <i>C3~4!60</i>
      <br />
      Holds only work on synthesized instruments. Volumes work on all of them.
      <br />
      <br />
      Imported songs can start with any of these lines, to set the tempo,
      sustain and whether the last played note is held:
      <br />
      <i>BPM: 120</i>, <i>SUSTAIN: linear 0.5</i> (seconds) or{' '}
      <i>SUSTAIN: exponential 1.4</i>, <i>HOLDLAST: on</i> or{' '}
      <i>HOLDLAST: off</i>
      <br />
      <br />
      Lines may be up to {max_line_chars} characters.
      <br />A song may only contain up to {max_lines} lines.
    </Section>
  );
};
