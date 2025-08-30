import {
  NoticeBox,
  Section,
  Stack,
  Table,
  Tooltip,
} from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { getAntagCategories } from './helpers';
import { OrbitSection } from './OrbitSection';
import { AntagGroup, Observable, OrbitData } from './types';

type ContentSection = {
  content: Observable[];
  title: string;
  color?: string;
};

export const OrbitContent = (props) => {
  const { act, data } = useBackend<OrbitData>();
  const { antagonists = [], critical = [] } = data;
  const { searchText, autoObserve } = props;

  let antagGroups: AntagGroup[] = [];
  if (antagonists.length) {
    antagGroups = getAntagCategories(antagonists);
  }

  const sections: readonly ContentSection[] = [
    {
      content: data.alive,
      title: 'Alive',
      color: 'good',
    },
    {
      content: data.dead,
      title: 'Dead',
    },
    {
      content: data.ghosts,
      title: 'Ghosts',
    },
    {
      content: data.ships,
      title: 'Ships',
    },
    {
      content: data.misc,
      title: 'Misc',
    },
    {
      content: data.npcs,
      title: 'NPCs',
    },
  ];

  return (
    <Section>
      <Stack vertical>
        {critical.map((crit) => (
          <Tooltip content="Click to orbit" key={crit.ref}>
            <NoticeBox
              verticalAlign
              color="purple"
              onClick={() => act('orbit', { ref: crit.ref })}
            >
              <Table>
                <Table.Row>
                  <Table.Cell>{toTitleCase(crit.full_name)}</Table.Cell>
                  <Table.Cell collapsing>{crit.extra}</Table.Cell>
                </Table.Row>
              </Table>
            </NoticeBox>
          </Tooltip>
        ))}

        {antagGroups.map(([title, members]) => (
          <OrbitSection
            color={'bad'}
            key={title}
            section={members}
            title={title}
            searchQuery={searchText}
            autoObserve={autoObserve}
          />
        ))}

        {sections.map((section) => (
          <OrbitSection
            color={section.color}
            key={section.title}
            section={section.content}
            title={section.title}
            searchQuery={searchText}
            autoObserve={autoObserve}
          />
        ))}
      </Stack>
    </Section>
  );
};
