import { useBackend } from '../backend';
import { formatSiUnit } from '../format';
import { Box, LabeledList, Section, ProgressBar } from '../components';
import { Window } from '../layouts';

export const ThermalGenerator = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    powernet,
    power,
    coldCircTemp,
    coldCircPressure,
    hotCircTemp,
    hotCircPressure,
    hotCirc,
    coldCirc,
  } = data;

  const maxPowerDisplay = 6 * 10 ** 9;

  const hasNoErrors = () => {
    return powernet && hotCirc && coldCirc;
  };

  return (
    <Window width={400} height={250} resizable>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Unit Status">
              {!powernet && (
                <Box color="bad">Not connected to power network!</Box>
              )}
              {!hotCirc && (
                <Box color="bad">Could not connect to hot circulator!</Box>
              )}
              {!coldCirc && (
                <Box color="bad">Could not connect to cold circulator!</Box>
              )}
              {hasNoErrors() && <Box color="good">Operational</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="Power Output">
              <ProgressBar
                value={power}
                minValue={0}
                maxValue={maxPowerDisplay}
                color="yellow"
              >
                {formatSiUnit(power, 0, 'W')}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Cold Loop">
              <ProgressBar
                value={coldCircTemp}
                minValue={0}
                maxValue={600}
                ranges={{
                  blue: [-Infinity, 293],
                  good: [293, 500],
                  average: [500, Infinity],
                }}
              >
                {coldCircTemp} K {coldCircPressure} kPa
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Hot Loop">
              <ProgressBar
                value={hotCircTemp}
                minValue={0}
                maxValue={600}
                ranges={{
                  blue: [-Infinity, 293],
                  good: [293, 500],
                  average: [500, Infinity],
                }}
              >
                {hotCircTemp} K {hotCircPressure} kPa
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
