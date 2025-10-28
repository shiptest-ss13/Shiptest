import { useBackend, useLocalState } from '../backend';
import { decodeHtmlEntities } from 'common/string';
import {
  Button,
  LabeledList,
  Section,
  Table,
  Tabs,
  Divider,
  NumberInput,
} from '../components';
import { Window } from '../layouts';

type ShipOwnerData = {
  crew: [CrewData];
  jobs: [JobData];
  jobIncreaseAllowed: [string];
  memo: string;
  pending: boolean;
  joinMode: string;
  crew_share: number;
  cooldown: number;
  applications: [ApplicationData];
  isAdmin: boolean;
};

type ApplicationData = {
  ref: string;
  key: string;
  name: string;
  text: string;
  status: string;
};

type CrewData = {
  ref: string;
  name: string;
  allowed: boolean;
};

type JobData = {
  ref: string;
  name: string;
  slots: number;
  max: number;
  def: number;
};

export const ShipOwner = (props, context) => {
  return (
    <Window width={620} height={620} resizable>
      <Window.Content scrollable>
        <ShipOwnerContent />
      </Window.Content>
    </Window>
  );
};

const ShipOwnerContent = (_, context: any) => {
  const { act, data } = useBackend<ShipOwnerData>(context);
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const {
    crew = [],
    jobs = [],
    memo,
    pending,
    joinMode,
    crew_share,
    cooldown = 1,
    applications = [],
    isAdmin,
    jobIncreaseAllowed = [],
  } = data;
  return (
    <Section
      title={'Ship Management'}
      buttons={
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Ship, Applications
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Ship Owner Options
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 3} onClick={() => setTab(3)}>
            Job Slots
          </Tabs.Tab>
        </Tabs>
      }
    >
      {(!memo || memo.length <= 0) && (
        <div className="NoticeBox">You need to set a ship memo!</div>
      )}
      {!!pending && (
        <div className="NoticeBox">You have pending applications!</div>
      )}
      {tab === 1 && (
        <>
          <LabeledList>
            <LabeledList.Item label="Join Settings">
              <Button
                content={joinMode}
                icon="bed"
                color={
                  joinMode === 'Open'
                    ? 'good'
                    : joinMode === 'Apply'
                    ? 'average'
                    : 'bad'
                }
                onClick={() => act('cycleJoin')}
              />
              <Button
                content="Check / Alter Memo"
                onClick={() => act('memo')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Current Memo">
              {decodeHtmlEntities(memo)}
            </LabeledList.Item>
          </LabeledList>
          <Divider />
          <Table>
            <Table.Row header>
              <Table.Cell>CKey</Table.Cell>
              <Table.Cell>Character Name</Table.Cell>
              <Table.Cell>Message</Table.Cell>
              <Table.Cell>Status</Table.Cell>
            </Table.Row>
            {applications.map((app: ApplicationData) => (
              <Table.Row key={app.ref}>
                <Table.Cell>{app.key}</Table.Cell>
                <Table.Cell>{app.name}</Table.Cell>
                <Table.Cell>{app.text}</Table.Cell>
                <Table.Cell>
                  {(app.status === 'pending' && (
                    <>
                      <Button
                        content="Approve"
                        color="good"
                        onClick={() =>
                          act('setApplication', {
                            ref: app.ref,
                            newStatus: 'yes',
                          })
                        }
                      />
                      <Button
                        content="Deny"
                        color="bad"
                        onClick={() =>
                          act('setApplication', {
                            ref: app.ref,
                            newStatus: 'no',
                          })
                        }
                      />
                    </>
                  )) || (
                    <>
                      <Button
                        content={app.status}
                        color={app.status === 'accepted' ? 'good' : 'bad'}
                      />
                      <Button
                        content="Delete"
                        color="black"
                        onClick={() =>
                          act('removeApplication', {
                            ref: app.ref,
                          })
                        }
                      />
                    </>
                  )}
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </>
      )}
      {tab === 2 && (
        <Table>
          <Table.Row header>
            <Table.Cell>Crewmember</Table.Cell>
            <Table.Cell>Can be owner</Table.Cell>
            <Table.Cell>Transfer Ownership</Table.Cell>
          </Table.Row>
          {crew.map((crew_data: CrewData) => (
            <Table.Row key={crew_data.name}>
              <Table.Cell>{crew_data.name}</Table.Cell>
              <Table.Cell>
                <Button.Checkbox
                  content="Candidate"
                  checked={crew_data.allowed}
                  onClick={() =>
                    act('toggleCandidate', {
                      ref: crew_data.ref,
                    })
                  }
                />
              </Table.Cell>
              <Table.Cell>
                <Button
                  content="Transfer Owner"
                  onClick={() =>
                    act('transferOwner', {
                      ref: crew_data.ref,
                    })
                  }
                />
              </Table.Cell>
            </Table.Row>
          ))}
          <LabeledList>
            <LabeledList.Item label="Crew Profit Share">
              <NumberInput
                animate
                unit="%"
                step={1}
                stepPixelSize={15}
                minValue={0}
                maxValue={7}
                value={crew_share * 100}
                onDrag={(e, value) =>
                  act('adjustshare', {
                    adjust: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Total Profit Shared">
              {crew_share * 100 * crew.length}
            </LabeledList.Item>
          </LabeledList>
        </Table>
      )}
      {tab === 3 && (
        <>
          {cooldown > 0 && (
            <div className="NoticeBox">
              {'On Cooldown: ' + cooldown / 10 + 's'}
            </div>
          )}
          <Table>
            <Table.Row header>
              <Table.Cell>Job Name</Table.Cell>
              <Table.Cell>Slots</Table.Cell>
            </Table.Row>
            {jobs.map((job: JobData) => (
              <Table.Row key={job.name}>
                <Table.Cell>{job.name}</Table.Cell>
                <Table.Cell>
                  <Button
                    content="+"
                    disabled={
                      !(isAdmin || jobIncreaseAllowed[job.name]) ||
                      cooldown > 0 ||
                      job.slots >= job.max
                    }
                    tooltip={
                      !jobIncreaseAllowed[job.name] && !isAdmin
                        ? 'Cannot increase job slots above maximum.'
                        : undefined
                    }
                    color={job.slots >= job.def ? 'average' : 'default'}
                    onClick={() =>
                      act('adjustJobSlot', {
                        toAdjust: job.ref,
                        delta: 1,
                      })
                    }
                  />
                  {job.slots}
                  <Button
                    content="-"
                    disabled={cooldown > 0 || job.slots <= 0}
                    onClick={() =>
                      act('adjustJobSlot', {
                        toAdjust: job.ref,
                        delta: -1,
                      })
                    }
                  />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </>
      )}
    </Section>
  );
};
