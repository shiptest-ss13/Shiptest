import {
  Button,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { getGasLabel } from '../constants';
import { Window } from '../layouts';

export const AtmosFilter = (props) => {
  const { act, data } = useBackend();
  const filterTypes = data.filter_types || [];
  return (
    <Window width={390} height={187}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Power">
              <Button
                icon={data.on ? 'power-off' : 'times'}
                content={data.on ? 'On' : 'Off'}
                selected={data.on}
                onClick={() => act('power')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Transfer Rate">
              <NumberInput
                animated
                value={parseFloat(data.rate)}
                width="63px"
                unit="L/s"
                minValue={0}
                maxValue={200}
                onDrag={(value) =>
                  act('rate', {
                    rate: value,
                  })
                }
              />
              <Button
                ml={1}
                icon="plus"
                content="Max"
                disabled={data.rate === data.max_rate}
                onClick={() =>
                  act('rate', {
                    rate: 'max',
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Filter">
              {filterTypes.map((filter) => (
                <Button
                  key={filter.id}
                  selected={filter.selected}
                  content={getGasLabel(filter.id, filter.name)}
                  onClick={() =>
                    act('filter', {
                      mode: filter.id,
                    })
                  }
                />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
