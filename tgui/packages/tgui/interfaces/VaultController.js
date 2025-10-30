import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const VaultController = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={300} height={120}>
      <Window.Content>
        <Section
          title="Lock Status: "
          buttons={
            <Button
              content={data.doorstatus ? 'Locked' : 'Unlocked'}
              icon={data.doorstatus ? 'lock' : 'unlock'}
              disabled={data.stored < data.max}
              onClick={() => act('togglelock')}
            />
          }
        >
          <LabeledList>
            <LabeledList.Item label="Charge">
              <ProgressBar
                value={data.stored / data.max}
                ranges={{
                  good: [1, Infinity],
                  average: [0.3, 1],
                  bad: [-Infinity, 0.3],
                }}
              >
                {toFixed(data.stored / 1000) +
                  ' / ' +
                  toFixed(data.max / 1000) +
                  ' kW'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
