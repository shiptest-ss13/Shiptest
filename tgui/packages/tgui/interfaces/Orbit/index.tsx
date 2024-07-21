
import { multiline } from '../../../common/string';
import { useBackend, useLocalState } from '../../backend';
import {
  Box,
  Button,
  Divider,
  Flex,
  Icon,
  Input,
  Section,
} from '../../components';
import { Window } from '../../layouts';

import { searchFor, compareString, compareNumberedText } from './helpers'
import { OrbitData } from './types';
import { OrbitContent } from './OrbitContent';

export const Orbit = (props, context) => {
  const { act, data } = useBackend<OrbitData>(context);
  const { antagonists, autoObserve } = data;

  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');

  const collatedAntagonists = {};
  for (const antagonist of antagonists) {
    if (collatedAntagonists[antagonist.antag] === undefined) {
      collatedAntagonists[antagonist.antag] = [];
    }
    collatedAntagonists[antagonist.antag].push(antagonist);
  }

  function orbitMostRelevant() {
    const mostRelevant = [
      data.antagonists,
      data.alive,
      data.ghosts,
      data.dead,
      data.npcs,
      data.misc,
      data.ships
    ]
      .flat()
      .filter(searchFor(searchText))
      .sort()[0];

      if (mostRelevant !== undefined) {
        act('orbit', { ref: mostRelevant.ref
        });
    }
  }

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
                tooltip={multiline`Toggle Auto-Observe. When active, you'll
                see the UI / full inventory of whoever you're orbiting. Neat!`}
                tooltipPosition="bottom-start"
                selected={autoObserve}
                icon={autoObserve ? 'toggle-on' : 'toggle-off'}
                onClick={() => act('toggle_observe')}
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
        <OrbitContent
          sortedAntagonists={data.antagonists}
          searchText={searchText}
        />
      </Window.Content>
    </Window>
  );
};
