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

import { Mission, Data } from './types';

export const MissionBoard = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {} = data;
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <MissionsContent />
      </Window.Content>
    </Window>
  );
};

const MissionsContent = (props, context) => {
  const { data } = useBackend<Data>(context);
  const { missions } = data;
  return (
    <Section title={'Available Missions '}>
      <MissionsList missions={missions} />
    </Section>
  );
};

const MissionsList = (props, context) => {
  const missionsArray = props.missions as Array<Mission>;
  const { act } = useBackend(context);

  const missionValues = (mission: Mission) => (
    <Stack vertical>
      <Stack.Item>
        <Box inline mx={1}>
          {`${mission.value} cr`}
        </Box>
      </Stack.Item>

      <Stack.Item>
        <ProgressBar
          ranges={{
            good: [0.75, 1],
            average: [0.25, 0.75],
            bad: [0, 0.25],
          }}
          value={mission.remaining / mission.duration}
        ></ProgressBar>
      </Stack.Item>
    </Stack>
  );

  const missionJSX = missionsArray.map((mission: Mission) => (
    <Stack title={mission.name}>
      <LabeledList.Item label="Cords">
        {mission.x}
        {','}
        {mission.y}
      </LabeledList.Item>
      <LabeledList.Item label="Author">{mission.author}</LabeledList.Item>
      <LabeledList.Item label="Faction">{mission.faction}</LabeledList.Item>
      <LabeledList.Item label="Description">{mission.desc}</LabeledList.Item>
      <LabeledList.Item label="Rewards">
        {missionValues(mission)}
      </LabeledList.Item>
      <LabeledList.Divider />
    </Stack>
  ));

  return <>{missionJSX}</>;
};
