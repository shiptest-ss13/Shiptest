import { useBackend } from '../backend';
import { Button, LabeledList, NumberInput, Section } from '../components';

export const AtmosRelief = props => {
  const { act, data } = useBackend(props);
  return (
    <Section>
      <LabeledList>
        <LabeledList.Item label="Open Pressure">
          <NumberInput
            animated
            value={parseFloat(data.open_pressure)}
            unit="kPa"
            width="75px"
            minValue={0}
            maxValue={4500}
            step={10}
            onChange={(e, value) => act('open_pressure', {
              open_pressure: value,
            })} />
          <Button
            ml={1}
            icon="plus"
            content="Max"
            disabled={data.open_pressure === data.max_pressure}
            onClick={() => act('open_pressure', {
              open_pressure: 'max',
            })} />
        </LabeledList.Item>
        <LabeledList.Item label="Close Pressure">
          <NumberInput
            animated
            value={parseFloat(data.close_pressure)}
            unit="kPa"
            width="75px"
            minValue={0}
            maxValue={data.open_pressure}
            step={10}
            onChange={(e, value) => act('close_pressure', {
              close_pressure: value,
            })} />
          <Button
            ml={1}
            icon="plus"
            content="Max"
            disabled={data.close_pressure === data.open_pressure}
            onClick={() => act('close_pressure', {
              close_pressure: 'max',
            })} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
