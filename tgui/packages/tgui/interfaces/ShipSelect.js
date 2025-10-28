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
import { createSearch, decodeHtmlEntities } from 'common/string';
import { logger } from '../logging';

const findShipByRef = (ship_list, ship_ref) => {
  for (let i = 0; i < ship_list.length; i++) {
    if (ship_list[i].ref === ship_ref) return ship_list[i];
  }
  return null;
};

export const ShipSelect = (props, context) => {
  const { act, data } = useBackend(context);

  const ships = data.ships || {};
  const templates = data.templates || [];

  const [currentTab, setCurrentTab] = useLocalState(context, 'tab', 1);
  const [selectedShipRef, setSelectedShipRef] = useLocalState(
    context,
    'selectedShipRef',
    null
  );

  const selectedShip = findShipByRef(ships, selectedShipRef);

  const applyStates = {
    open: 'Open',
    apply: 'Apply',
    closed: 'Locked',
  };

  const [shownTabs, setShownTabs] = useLocalState(context, 'tabs', [
    { name: 'Ship Select', tab: 1 },
    { name: 'Ship Purchase', tab: 3 },
  ]);
  const searchFor = (searchText) =>
    createSearch(searchText, (thing) => thing.name);

  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');

  return (
    <Window title="Ship Select" width={800} height={600} resizable>
      <Window.Content scrollable>
        <Tabs>
          {shownTabs.map((tabbing, index) => (
            <Tabs.Tab
              key={`${index}-${tabbing.name}`}
              selected={currentTab === tabbing.tab}
              onClick={() => setCurrentTab(tabbing.tab)}
            >
              {tabbing.name}
            </Tabs.Tab>
          ))}
        </Tabs>
        {currentTab === 1 && (
          <Section
            title="Active Ship Selection"
            buttons={
              <>
                <Button
                  content="Purchase Ship"
                  tooltip={
                    /* worth noting that disabled ship spawn doesn't cause the
                  button to be disabled, as we want to let people look around */
                    (data.purchaseBanned &&
                      'You are banned from purchasing ships.') ||
                    (!data.shipSpawnAllowed &&
                      'No more ships may be spawned at this time.') ||
                    (data.shipSpawning &&
                      'A ship is currently spawning. Please wait.')
                  }
                  disabled={data.purchaseBanned}
                  onClick={() => {
                    setCurrentTab(3);
                  }}
                />
                <Button
                  content="?"
                  tooltip={"Hover over a ship's name to see its faction."}
                />
              </>
            }
          >
            <Table>
              <Table.Row header>
                <Table.Cell collapsing>Join</Table.Cell>
                <Table.Cell>Ship Name</Table.Cell>
                <Table.Cell>Ship Class</Table.Cell>
              </Table.Row>
              {Object.values(ships).map((ship) => {
                const shipName = decodeHtmlEntities(ship.name);
                const shipFaction = ship.faction;
                return (
                  <Table.Row key={shipName}>
                    <Table.Cell>
                      <Button
                        content={
                          ship.joinMode === applyStates.apply ? 'Apply' : 'Join'
                        }
                        color={
                          ship.joinMode === applyStates.apply
                            ? 'average'
                            : 'good'
                        }
                        onClick={() => {
                          setSelectedShipRef(ship.ref);
                          setCurrentTab(2);
                          const newTab = {
                            name: 'Job Select',
                            tab: 2,
                          };
                          // check if the tab already exists
                          const tabExists = shownTabs.some(
                            (tab) =>
                              tab.name === newTab.name && tab.tab === newTab.tab
                          );
                          if (tabExists) {
                            return;
                          }
                          setShownTabs((tabs) => {
                            logger.log(tabs);
                            const newTabs = [...tabs];
                            newTabs.splice(1, 0, newTab);
                            return newTabs;
                          });
                        }}
                      />
                    </Table.Cell>
                    <Table.Cell title={shipFaction}>{shipName}</Table.Cell>
                    <Table.Cell>{ship.class}</Table.Cell>
                  </Table.Row>
                );
              })}
            </Table>
          </Section>
        )}
        {currentTab === 2 && (
          <>
            <Section
              title={`Ship Details - ${decodeHtmlEntities(selectedShip.name)}`}
            >
              <LabeledList>
                <LabeledList.Item label="Ship Class">
                  {selectedShip.class}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Faction">
                  {selectedShip.faction}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Join Status">
                  {selectedShip.joinMode}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Memo">
                  {decodeHtmlEntities(selectedShip.memo) || 'No Memo'}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <Collapsible title={'Ship Info'}>
              <LabeledList>
                <LabeledList.Item label="Ship Description">
                  {selectedShip.desc || 'No Description'}
                </LabeledList.Item>
                <LabeledList.Item label="Ship Tags">
                  {(selectedShip.tags && selectedShip.tags.join(', ')) ||
                    'No Tags Set'}
                </LabeledList.Item>
              </LabeledList>
            </Collapsible>
            <Section
              title="Job Selection"
              buttons={
                <Button
                  content="Back"
                  onClick={() => {
                    setCurrentTab(1);
                  }}
                />
              }
            >
              <Table>
                <Table.Row header>
                  <Table.Cell collapsing>Join</Table.Cell>
                  <Table.Cell>Job Name</Table.Cell>
                  <Table.Cell>Slots</Table.Cell>
                  <Table.Cell>Min. Playtime</Table.Cell>
                </Table.Row>
                {selectedShip.jobs.map((job) => (
                  <Table.Row key={job.name}>
                    <Table.Cell>
                      <Button
                        content="Select"
                        tooltip={
                          (!data.autoMeet &&
                            data.playMin < job.minTime &&
                            'You do not have enough playtime to play this job.') ||
                          (data.officerBanned &&
                            'You are banned from playing officer roles')
                        }
                        disabled={
                          (!data.autoMeet && data.playMin < job.minTime) ||
                          (data.officerBanned && job.officer)
                        }
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
                    <Table.Cell>
                      {formatShipTime(job.minTime, data.playMin, data.autoMeet)}
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </>
        )}
        {currentTab === 3 && (
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
                    setCurrentTab(1);
                  }}
                />
              </>
            }
          >
            {templates.filter(searchFor(searchText)).map((template) => (
              <Collapsible
                title={template.name}
                key={template.name}
                color={
                  (!data.shipSpawnAllowed && 'average') ||
                  ((template.curNum >= template.limit ||
                    (!data.autoMeet && data.playMin < template.minTime)) &&
                    'grey') ||
                  'default'
                }
                buttons={
                  <Button
                    content="Buy"
                    tooltip={
                      (!data.shipSpawnAllowed &&
                        'No more ships may be spawned at this time.') ||
                      (template.curNum >= template.limit &&
                        'There are too many ships of this type.') ||
                      (!data.autoMeet &&
                        data.playMin < template.minTime &&
                        'You do not have enough playtime to buy this ship.') ||
                      (data.shipSpawning &&
                        'A ship is currently spawning. Please wait.')
                    }
                    disabled={
                      !data.shipSpawnAllowed ||
                      data.shipSpawning ||
                      template.curNum >= template.limit ||
                      (!data.autoMeet && data.playMin < template.minTime)
                    }
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
                    {template.desc || 'No Description'}
                  </LabeledList.Item>
                  <LabeledList.Item label="Ship Faction">
                    {template.faction}
                  </LabeledList.Item>
                  <LabeledList.Item label="Ship Tags">
                    {(template.tags && template.tags.join(', ')) ||
                      'No Tags Set'}
                  </LabeledList.Item>
                  <LabeledList.Item label="Std. Crew">
                    {template.crewCount}
                  </LabeledList.Item>
                  <LabeledList.Item label="Max #">
                    {template.limit}
                  </LabeledList.Item>
                  <LabeledList.Item label="Min. Playtime">
                    {formatShipTime(
                      template.minTime,
                      data.playMin,
                      data.autoMeet
                    )}
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

const formatShipTime = (minTime, playMin, autoMeet) => {
  return (
    (minTime <= 0 && '-') ||
    minTime + 'm ' + ((!autoMeet && playMin < minTime && '(Unmet)') || '(Met)')
  );
};
