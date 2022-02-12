import { useBackend } from '../backend';
import { Button, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const ThermalGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    powernet,
    output,
    power,
    cold_circ_temp,
    cold_circ_pressure,
    hot_circ_temp,
    hot_circ_pressure,
    hot_circ,
    cold_circ,
  } = data;
  return (
    <Window title="Thermo-Electric Generator" width={900} height={500} resizable>
      <Window.Content>
        <Section title="Legend:">
          Output:
          <ProgressBar
            value={power}
            minValue={0}
            maxValue={6000000000}
            color="yellow"/>
            {output}
          <br />
          Cold loop:
          <ProgressBar
            value={cold_circ_temp}
            minValue={0}
            maxValue={600}
            ranges={{
              blue: [-Infinity, 293],
              average: [293, 500],
              bad: [500, Infinity],
            }}>
            {cold_circ_temp} K {cold_circ_pressure} kPa
          </ProgressBar>
          Hot loop:
          <ProgressBar
            value={hot_circ_temp}
            minValue={0}
            maxValue={600}
            ranges={{
              blue: [-Infinity, 293],
              average: [293, 500],
              bad: [500, Infinity],
            }}>
            {hot_circ_temp} K {hot_circ_pressure} kPa
          </ProgressBar>
        </Section>
      </Window.Content>
    </Window>
  );
};
