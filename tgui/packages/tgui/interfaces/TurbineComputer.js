import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { formatSiUnit } from '../format';
import { Window } from '../layouts';

export const TurbineComputer = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window width={310} height={44 + data.engines.length * 140}>
      <Window.Content>
        <Button
          icon="sync"
          content="Reconnect"
          onClick={() => act('reconnect')}
          mb={1}
        />
        {data.engines
          ? data.engines.map((compressor, key) => (
              <TurbineData comp_data={compressor} key={key} />
            ))
          : 'No turbine engines detected!'}
      </Window.Content>
    </Window>
  );
};

const TurbineData = (props, context) => {
  const { act, data } = useBackend(context);
  const comp_data = props.comp_data;
  const operational = Boolean(
    !comp_data.compressor_broke && !comp_data.turbine_broke
  );
  return (
    <Section
      title={
        comp_data.engine_id && data.computer_id !== comp_data.engine_id
          ? comp_data.engine_id
          : 'Status'
      }
      buttons={
        <Button
          icon={comp_data.online ? 'power-off' : 'times'}
          content={comp_data.online ? 'Online' : 'Offline'}
          selected={comp_data.online}
          disabled={!operational}
          onClick={() => act('toggle_power', { comp_ref: comp_data.comp_ref })}
        />
      }
    >
      {(!operational && (
        <LabeledList>
          <LabeledList.Item
            label="Compressor Status"
            color={comp_data.compressor_broke ? 'bad' : 'good'}
          >
            {comp_data.compressor_broke
              ? comp_data.compressor
                ? 'Offline'
                : 'Missing'
              : 'Online'}
          </LabeledList.Item>
          <LabeledList.Item
            label="Turbine Status"
            color={comp_data.turbine_broke ? 'bad' : 'good'}
          >
            {comp_data.turbine_broke
              ? comp_data.turbine
                ? 'Offline'
                : 'Missing'
              : 'Online'}
          </LabeledList.Item>
        </LabeledList>
      )) || (
        <LabeledList>
          <LabeledList.Item label="Turbine Speed">
            {comp_data.rpm} RPM
          </LabeledList.Item>
          <LabeledList.Item label="Internal Temp">
            {comp_data.temp} K
          </LabeledList.Item>
          <LabeledList.Item label="Internal Pressure">
            {formatSiUnit(comp_data.pressure * 1000, 1, 'Pa')}
          </LabeledList.Item>
          <LabeledList.Item label="Generated Power">
            {comp_data.power}
          </LabeledList.Item>
        </LabeledList>
      )}
    </Section>
  );
};
