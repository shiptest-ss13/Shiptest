import {
  Button,
  Divider,
  LabeledList,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const CryoStorageConsole = (props) => {
  return (
    <Window width={450} height={620}>
      <Window.Content scrollable>
        <CryoStorageConsoleContent />
      </Window.Content>
    </Window>
  );
};

export const CryoStorageConsoleContent = (props) => {
  const { act, data } = useBackend();
  const { stored = [], hasItems, allowItems } = data;
  return (
    <Section title="Cryo Management">
      <LabeledList>
        <LabeledList.Item label="Eject Item">
          <Button
            content={allowItems ? 'Disable' : 'Enable'}
            icon={allowItems ? 'ban' : 'check'}
            color={allowItems ? 'bad' : 'good'}
            onClick={() => act('toggleStorage')}
          />
          <Button
            content="Eject one"
            icon="eject"
            disabled={!hasItems}
            onClick={() => act('items')}
          />
          <Button
            content="Eject all"
            icon="eject"
            color="bad"
            disabled={!hasItems}
            onClick={() => act('allItems')}
          />
        </LabeledList.Item>
      </LabeledList>
      <Divider />
      <Table>
        <Table.Row header>
          <Table.Cell>Time Frozen</Table.Cell>
          <Table.Cell>Name</Table.Cell>
          <Table.Cell>Occupation</Table.Cell>
        </Table.Row>
        {stored.map((storedPerson) => (
          <Table.Row key={storedPerson.name} className="candystripe">
            <Table.Cell>{storedPerson.time}</Table.Cell>
            <Table.Cell>{storedPerson.name}</Table.Cell>
            <Table.Cell>{storedPerson.rank}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
