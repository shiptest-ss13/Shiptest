import {
  Button,
  Divider,
  Flex,
  Icon,
  Input,
  Section,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';
import { searchFor } from './helpers';
import { OrbitContent } from './OrbitContent';
import { OrbitData } from './types';

export const Orbit = (props) => {
  const { act, data } = useBackend<OrbitData>();

  const [searchText, setSearchText] = useLocalState('searchText', '');
  const [autoObserve, setAutoObserve] = useLocalState('autoObserve', false);

  const orbitMostRelevant = () => {
    const mostRelevant = [
      data.antagonists,
      data.alive,
      data.ghosts,
      data.dead,
      data.ships,
      data.misc,
      data.npcs,
    ]
      .flat()
      .filter(searchFor(searchText))
      .sort()[0];

    if (mostRelevant !== undefined) {
      act('orbit', { ref: mostRelevant.ref });
    }
  };

  return (
    <Window title="Orbit" width={350} height={700}>
      <Window.Content scrollable>
        <Section>
          <Flex>
            <Flex.Item>
              <Icon name="search" mr={1} />
            </Flex.Item>
            <Flex.Item grow={1}>
              <Input
                placeholder="Search..."
                autoFocus
                fluid
                value={searchText}
                onInput={(_, value) => setSearchText(value)}
                onEnter={(_, value) => orbitMostRelevant()}
              />
            </Flex.Item>
            <Flex.Item>
              <Divider vertical />
            </Flex.Item>
            <Flex.Item>
              <Button
                inline
                color="transparent"
                tooltip={`Toggle Auto-Observe. When active, you'll
                see the UI / full inventory of whoever you're orbiting. Neat!`}
                tooltipPosition="bottom-start"
                selected={autoObserve}
                icon={autoObserve ? 'toggle-on' : 'toggle-off'}
                onClick={() => setAutoObserve(!autoObserve)}
              />
              <Button
                inline
                color="transparent"
                tooltip="Refresh"
                tooltipPosition="bottom-start"
                icon="sync-alt"
                onClick={() => act('refresh')}
              />
            </Flex.Item>
          </Flex>
        </Section>
        <OrbitContent searchText={searchText} autoObserve={autoObserve} />
      </Window.Content>
    </Window>
  );
};
