import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Section, Table, Tabs, Dimmer, NoticeBox, Divider } from '../components';
import { ButtonInput } from '../components/Button';
import { TableCell, TableRow } from '../components/Table';
import { Window } from '../layouts';

export const CryoStorageConsole = (props, context) => {
  return (
    <Window
      width={450}
      height={620}
      resizable>
      <Window.Content scrollable>
        <CryoStorageConsoleContent />
      </Window.Content>
    </Window>
  );
};

export const CryoStorageConsoleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const {
    stored = [],
    jobs = [],
    memo,
    hasItems,
    awakening,
    allowItems,
    cooldown = 1,
  } = data;
  return (
    <Section
      title={"Cryo Management"}
      buttons={(
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Management
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Storage Log
          </Tabs.Tab>
        </Tabs>
      )}>
      {tab === 1 && (
        <>
          <LabeledList>
            <LabeledList.Item label="Eject Item">
              <Button
                content={allowItems ? "Disable" : "Enable"}
                icon={allowItems ? "ban" : "check"}
                color={allowItems ? "bad" : "good"}
                onClick={() => act('toggleStorage')} />
              <Button
                content="Eject one"
                icon="eject"
                disabled={!hasItems}
                onClick={() => act('items')} />
              <Button
                content="Eject all"
                icon="eject"
                color="bad"
                disabled={!hasItems}
                onClick={() => act('allItems')} />
            </LabeledList.Item>
            <LabeledList.Item label="Awakening Settings">
              <Button
                content={awakening ? "Disable" : "Enable"}
                icon="bed"
                color={awakening ? "bad" : "good"}
                onClick={() => act('toggleAwakening')} />
              <Button.Input
                content="Set Memo"
                currentValue={memo}
                onCommit={(e, value) => act('setMemo', {
                  newName: value,
                })} />
            </LabeledList.Item>
          </LabeledList>
          <Divider />
          {cooldown > 0 && (
            <div className="NoticeBox">
              {"On Cooldown: " + (cooldown / 10) + "s"}
            </div>
            )}
          <Table>
            <Table.Row header>
              <Table.Cell>
                Job Name
              </Table.Cell>
              <Table.Cell>
                Slots
              </Table.Cell>
            </Table.Row>
            {jobs.map(job => (
              <Table.Row>
                <Table.Cell key={job.name}>
                  {job.name}
                </Table.Cell>
                <TableCell>
                  <Button
                    content="+"
                    disabled={cooldown > 0 || job.slots >= job.max}
                    onClick={() => act('adjustJobSlot', {
                      toAdjust: job.ref,
                      delta: 1,
                    })} />
                   {job.slots}
                  <Button
                    content="-"
                    disabled={cooldown > 0 || job.slots <= 0}
                    onClick={() => act('adjustJobSlot', {
                      toAdjust: job.ref,
                      delta: -1,
                    })} />
                </TableCell>
              </Table.Row>
            ))}
          </Table>
        </>
      )}
      {tab === 2 && (
        <Table>
          <Table.Row header>
            <Table.Cell>
              Time Frozen
            </Table.Cell>
            <Table.Cell>
              Name
            </Table.Cell>
            <Table.Cell>
              Occupation
            </Table.Cell>
          </Table.Row>
          {stored.map(storedPerson => (
            <Table.Row
              key={storedPerson.name}
              className="candystripe">
              <Table.Cell>
                {storedPerson.time}
              </Table.Cell>
              <Table.Cell>
                {storedPerson.name}
              </Table.Cell>
              <Table.Cell>
                {storedPerson.rank}
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};
