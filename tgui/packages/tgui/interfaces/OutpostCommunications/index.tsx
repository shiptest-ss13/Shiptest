import { useBackend, useSharedState } from '../../backend';
import {
  ProgressBar,
  Section,
  Tabs,
  Button,
  LabeledList,
  Box,
  Stack,
} from '../../components';
import { Window } from '../../layouts';

import { CargoCatalog } from './Catalog';
import { Mission, Data } from './types';

export const OutpostCommunications = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { outpostDocked, onShip, points } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <Section
          title={Math.round(points) + ' credits'}
          buttons={
            <Stack textAlign="center">
              <Stack.Item>
                <Tabs>
                  {!!outpostDocked && (
                    <Tabs.Tab
                      selected={tab === 'cargo'}
                      onClick={() => setTab('cargo')}
                    >
                      Cargo
                    </Tabs.Tab>
                  )}
                  {!!onShip && (
                    <Tabs.Tab
                      selected={tab === 'shipMissions'}
                      onClick={() => setTab('shipMissions')}
                    >
                      Current Missions
                    </Tabs.Tab>
                  )}
                  {!!outpostDocked && (
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
        {tab === 'shipMissions' && !!onShip && <ShipMissionsContent />}
        {tab === 'outpostMissions' && !!outpostDocked && (
          <OutpostMissionsContent />
        )}
      </Window.Content>
    </Window>
  );
};

const CargoExpressContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { message } = data;
  return (
    <>
      <Section title="Cargo Express">
        <LabeledList>
          <LabeledList.Item label="Notice">{message}</LabeledList.Item>
        </LabeledList>
      </Section>
      <CargoCatalog />
    </>
  );
};

const ShipMissionsContent = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { numMissions, maxMissions, outpostDocked, shipMissions } = data;
  return (
    <Section title={'Current Missions ' + numMissions + '/' + maxMissions}>
      <MissionsList showButton={outpostDocked} missions={shipMissions} />
    </Section>
  );
};

const OutpostMissionsContent = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { numMissions, maxMissions, outpostDocked, outpostMissions } = data;
  const disabled = numMissions >= maxMissions;
  return (
    <Section title={'Available Missions ' + numMissions + '/' + maxMissions}>
      <MissionsList
        showButton={outpostDocked}
        missions={outpostMissions}
        disabled={disabled}
        tooltip={(disabled && 'You have too many missions!') || null}
      />
    </Section>
  );
};

const MissionsList = (props, context) => {
  const showButton = props.showButton as Boolean;
  const disabled = props.disabled as Boolean;
  const tooltip = props.tooltip as string;
  const missionsArray = props.missions as Array<Mission>;
  const { act } = useBackend(context);
  //   const { numMissions, maxMissions } = data;

  const buttonJSX = (mission: Mission, tooltip: string, disabled: Boolean) => {
    return (
      <Button
        disabled={disabled}
        tooltip={tooltip}
        onClick={() =>
          act('mission-act', {
            ref: mission.ref,
          })
        }
      >
        {mission.actStr}
      </Button>
    );
  };

  const missionValues = (mission: Mission) => (
    <Stack vertical>
      <Stack.Item>
        <Box inline mx={1}>
          {`${mission.value} cr`}
        </Box>
      </Stack.Item>

      <Stack.Item>
        <Box inline mx={1}>
          {`Completed: ${mission.progressStr}`}
        </Box>
      </Stack.Item>

      <Stack.Item>
        <ProgressBar
          ranges={{
            good: [0.75, 1],
            average: [0.25, 0.75],
            bad: [0, 0.25],
          }}
          value={mission.progressPer}
        />
      </Stack.Item>

      <Stack.Item>
        {(showButton && buttonJSX(mission, tooltip, disabled)) || undefined}
      </Stack.Item>
    </Stack>
  );

  const missionJSX = missionsArray.map((mission: Mission) => (
    <>
      <LabeledList.Item
        verticalAlign="top"
        labelWrap
        label={mission.name}
        buttons={missionValues(mission)}
      >
        {mission.desc}
      </LabeledList.Item>
      <LabeledList.Divider />
    </>
  ));

  return <LabeledList>{missionJSX}</LabeledList>;
};
