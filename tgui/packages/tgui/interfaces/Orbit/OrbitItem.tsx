import { Button, Flex, Icon, Stack } from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { getDisplayColor, getDisplayName } from './helpers';
import { Antagonist, Observable, OrbitData } from './types';

type Props = {
  item: Observable | Antagonist;
  autoObserve: boolean;
  color: string | undefined;
};

export const OrbitItem = (props: Props) => {
  const { item, autoObserve, color } = props;
  const { full_name, icon, job, name, orbiters, ref } = item;

  const { act, data } = useBackend<OrbitData>();
  const { orbiting } = data;

  const selected = ref === orbiting?.ref;
  const validIcon = !!job && !!icon && icon !== 'hudunknown';

  return (
    <Flex.Item
      mb={0.5}
      mr={0.5}
      onClick={() => act('orbit', { auto_observe: autoObserve, ref })}
      style={{
        display: 'flex',
      }}
    >
      <Button color={getDisplayColor(item, color)} pl={validIcon && 0.5}>
        <Stack>
          <Stack.Item>
            {capitalizeFirst(getDisplayName(full_name, name))}
          </Stack.Item>
          {!!orbiters && (
            <Stack.Item>
              <Icon name="ghost" />
              {orbiters}
            </Stack.Item>
          )}
        </Stack>
        {selected && <div className="OrbitItem__selected" />}
      </Button>
    </Flex.Item>
  );
};
