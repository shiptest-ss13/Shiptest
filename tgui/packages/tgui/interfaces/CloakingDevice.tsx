import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Slider,
} from '../components';
import { formatSiUnit } from '../format';
import { Window } from '../layouts';

type CloakingData = {
  linked_ship: boolean;
  cloak_active: boolean;
  recharge_rate: number;
  current_charge: number;
  available_power: number;
  power_consumption: number;
  max_recharge_rate: number;
  max_charge: number;
  observer: boolean;
};

export const CloakingDevice = (props, context) => {
  const { act, data } = useBackend<CloakingData>(context);
  const {
    linked_ship,
    cloak_active,
    recharge_rate,
    current_charge,
    available_power,
    power_consumption,
    max_recharge_rate,
    max_charge,
    observer,
  } = data;
  const POWER_MUL = 1000;

  return (
    <Window width={340} height={170}>
      <Window.Content>
        <Section
          title={
            <Button
              icon={cloak_active ? 'power-off' : 'times'}
              selected={cloak_active}
              disabled={!linked_ship || observer}
              onClick={() => act('toggle_cloak')}
            >
              {cloak_active ? 'Deactivate Cloaking' : 'Activate Cloaking'}
            </Button>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Stored Energy">
              <ProgressBar
                value={current_charge}
                minValue={0}
                maxValue={max_charge}
                ranges={{
                  good: [max_charge * 0.5, Infinity],
                  average: [max_charge * 0.15, max_charge * 0.5],
                  bad: [-Infinity, max_charge * 0.15],
                }}
              >
                {formatSiUnit(current_charge, 1, 'J')}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Recharge Rate">
              <Slider
                value={recharge_rate / POWER_MUL}
                fillValue={available_power / POWER_MUL}
                minValue={0}
                maxValue={max_recharge_rate / POWER_MUL}
                step={5}
                stepPixelSize={(960 * POWER_MUL) / max_recharge_rate}
                format={(value) => formatSiUnit(value * POWER_MUL, 1, 'W')}
                onDrag={(e, value) =>
                  act('set_charge_rate', {
                    target: value * POWER_MUL,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Power Draw">
              <Box>{formatSiUnit(power_consumption, 1, 'W')}</Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
