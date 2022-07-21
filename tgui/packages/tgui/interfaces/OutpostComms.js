import { useBackend, useSharedState } from '../backend';
import {
  ProgressBar,
  Section,
  Tabs,
  Button,
  LabeledList,
  Box,
  Stack,
} from '../components';
import { Window } from '../layouts';
import { CargoCatalog } from './Cargo';

export const OutpostComms = (props, context) => {
  const { act, data } = useBackend(context);
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <Section
          fitted
          title={Math.round(data.points) + ' credits'}
          buttons={
            <Stack textAlign="center">
              <Stack.Item>
                <Tabs>
                  {!!data.outpostDocked && (
                    <Tabs.Tab
                      selected={tab === 'cargo'}
                      onClick={() => setTab('cargo')}
                    >
                      Cargo
                    </Tabs.Tab>
                  )}
                  {!!data.onShip && (
                    <Tabs.Tab
                      selected={tab === 'shipMissions'}
                      onClick={() => setTab('shipMissions')}
                    >
                      Current Missions
                    </Tabs.Tab>
                  )}
                  {!!data.outpostDocked && (
                    <Tabs.Tab
                      selected={tab === 'outpostMissions'}
                      onClick={() => setTab('outpostMissions')}
                    >
                      Available Missions
                    </Tabs.Tab>
                  )}
                </Tabs>
              </Stack.Item>
              <Stack.Item>
                <Button.Input
                  content="Withdraw Cash"
                  currentValue={100}
                  defaultValue={100}
                  onCommit={(e, value) =>
                    act('withdrawCash', {
                      value: value,
                    })
                  }
                />
              </Stack.Item>
            </Stack>
          }
        />
        {tab === 'cargo' && <CargoExpressContent />}
        {tab === 'shipMissions' && !!data.onShip && <ShipMissionsContent />}
        {tab === 'outpostMissions' && !!data.outpostDocked && (
          <OutpostMissionsContent />
        )}
      </Window.Content>
    </Window>
  );
};

const CargoExpressContent = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <>
      <Section title="Cargo Express">
        <LabeledList>
          <LabeledList.Item label="Landing Location">
            <Button
              content="Cargo Bay"
              selected={!data.usingBeacon}
              onClick={() => act('LZCargo')}
            />
            <Button
              selected={data.usingBeacon}
              disabled={!data.hasBeacon}
              onClick={() => act('LZBeacon')}
            >
              {data.beaconzone} ({data.beaconName})
            </Button>
            <Button
              content={data.printMsg}
              disabled={!data.canBuyBeacon}
              onClick={() => act('printBeacon')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Notice">{data.message}</LabeledList.Item>
        </LabeledList>
      </Section>
      <CargoCatalog express />
    </>
  );
};

const ShipMissionsContent = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section
      title={'Current Missions ' + data.numMissions + '/' + data.maxMissions}
    >
      <MissionsList
        showButton={data.outpostDocked}
        missions={data.shipMissions}
      />
    </Section>
  );
};

const OutpostMissionsContent = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section
      title={'Available Missions ' + data.numMissions + '/' + data.maxMissions}
    >
      <MissionsList
        showButton={data.outpostDocked}
        missions={data.outpostMissions}
      />
    </Section>
  );
};

const MissionsList = (props, context) => {
  const showButton = props.showButton;
  const missions = props.missions;
  const { act } = useBackend(context);
  return missions.map((mission) => (
    <Section
      key={mission.ref}
      title={mission.name}
      level={2}
      buttons={
        <>
          <Box inline mx={1}>
            {mission.value + ' cr ' + mission.progressStr}
          </Box>
          <ProgressBar
            ranges={{
              good: [0.75, 1],
              average: [0.25, 0.75],
              bad: [0, 0.25],
            }}
            value={mission.remaining / mission.duration}
          >
            {mission.timeStr}
          </ProgressBar>
        </>
      }
    >
      {mission.desc}
      {!!showButton && (
        <Button
          onClick={() =>
            act('mission-act', {
              ref: mission.ref,
            })
          }
        >
          {mission.actStr}
        </Button>
      )}
    </Section>
  ));
};
