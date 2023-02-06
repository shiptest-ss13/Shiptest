import { useBackend, useLocalState } from '../backend';
import {
  Button,
  Input,
  Section,
  Tabs,
  Table,
  LabeledList,
  Collapsible,
} from '../components';
import { Window } from '../layouts';
import { createSearch } from 'common/string';

export const ShipSelect = (props, context) => {
  const { act, data } = useBackend(context);

  const ships = data.ships || {};
  const templates = data.templates || [];

  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const [selectedShip, setSelectedShip] = useLocalState(
    context,
    'selectedShip',
    null
  );

  const applyStates = {
    open: 'Open',
    apply: 'Apply',
    closed: 'Locked',
  };

  const searchFor = (searchText) =>
    createSearch(searchText, (thing) => thing.name);

  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');

  return (
    <Window title="Ship Select" width={800} height={600} resizable>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1}>Ship Select</Tabs.Tab>
          <Tabs.Tab selected={tab === 2}>Job Select</Tabs.Tab>
          <Tabs.Tab selected={tab === 3}>Ship Purchase</Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <Section
            title="Active Ship Selection"
            buttons={
              <Button
                content="Purchase Ship"
                onClick={() => {
                  setTab(3);
                }}
              />
            }
          >
            <Table>
              <Table.Row header>
                <Table.Cell collapsing>Join</Table.Cell>
                <Table.Cell>Ship Name</Table.Cell>
                <Table.Cell>Ship Class</Table.Cell>
              </Table.Row>
              {Object.values(ships).map((ship) => (
                <Table.Row key={ship.name}>
                  <Table.Cell>
                    <Button
                      content={
                        ship.joinMode === applyStates.apply ? 'Apply' : 'Join'
                      }
                      color={
                        ship.joinMode === applyStates.apply ? 'average' : 'good'
                      }
                      onClick={() => {
                        setSelectedShip(ship);
                        setTab(2);
                      }}
                    />
                  </Table.Cell>
                  <Table.Cell>{ship.name}</Table.Cell>
                  <Table.Cell>{ship.class}</Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        )}
        {tab === 2 && (
          <>
            <Section title={`Ship Info - ${selectedShip.name}`}>
              <LabeledList>
                <LabeledList.Item label="Ship Class">
                  {selectedShip.class}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Join Status">
                  {selectedShip.joinMode}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Memo">
                  {selectedShip.memo || 'No Memo'}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Section
              title="Job Selection"
              buttons={
                <Button
                  content="Back"
                  onClick={() => {
                    setTab(1);
                  }}
                />
              }
            >
              <Table>
                <Table.Row header>
                  <Table.Cell collapsing>Join</Table.Cell>
                  <Table.Cell>Job Name</Table.Cell>
                  <Table.Cell>Slots</Table.Cell>
                </Table.Row>
                {selectedShip.jobs.map((job) => (
                  <Table.Row key={job.name}>
                    <Table.Cell>
                      <Button
                        content="Select"
                        onClick={() => {
                          act('join', {
                            ship: selectedShip.ref,
                            job: job.ref,
                          });
                        }}
                      />
                    </Table.Cell>
                    <Table.Cell>{job.name}</Table.Cell>
                    <Table.Cell>{job.slots}</Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </>
        )}
        {tab === 3 && (
          <Section
            title="Ship Purchase"
            buttons={
              <>
                <Input
                  placeholder="Search..."
                  autoFocus
                  value={searchText}
                  onInput={(_, value) => setSearchText(value)}
                />

                <Button
                  content="Back"
                  onClick={() => {
                    setTab(1);
                  }}
                />
              </>
            }
          >
            {templates.filter(searchFor(searchText)).map((template) => (
              <Collapsible
                title={template.name}
                key={template.name}
                buttons={
                  <Button
                    content="Buy"
                    onClick={() => {
                      act('buy', {
                        name: template.name,
                      });
                    }}
                  />
                }
              >
                <LabeledList>
                  <LabeledList.Item label="Description">
                    {template.description || 'No Description'}
                  </LabeledList.Item>
                  <LabeledList.Item label="Crew">
                    {template.crewCount}
                  </LabeledList.Item>
                  <LabeledList.Item label="Wiki Link">
                    <a
                      href={'https://shiptest.net/wiki/' + template.name}
                      target="_blank"
                      rel="noreferrer"
                    >
                      Here
                    </a>
                  </LabeledList.Item>
                </LabeledList>
              </Collapsible>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
