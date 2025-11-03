import { useBackend } from '../../backend';
import {
  ProgressBar,
  Section,
  Button,
  LabeledList,
  Box,
} from '../../components';
import { Window } from '../../layouts';

import { Mission, Data } from './types';

export const MissionBoard = (props, context) => {
  return (
    <Window width={600} height={700} theme="ntos_terminal" resizable>
      <Window.Content scrollable>
        <MissionsContent />
      </Window.Content>
    </Window>
  );
};

export const MissionsContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { missions, pad, id_inserted } = data;
  return (
    <Section
      title={'Available Missions'}
      buttons={
        <>
          <Button
            icon={'sync'}
            tooltip={'Refresh'}
            onClick={() => act('recalc')}
          />
          <Button
            icon={'download'}
            content={'Eject ID'}
            disabled={!id_inserted}
            onClick={() => act('eject')}
          />
        </>
      }
    >
      <MissionsList missions={missions} />
    </Section>
  );
};

const MissionsList = (props, context) => {
  const missionsArray = props.missions as Array<Mission>;
  const { act, data } = useBackend<Data>(context);
  const { pad, id_inserted } = data;

  const missionTimer = (mission: Mission) => (
    <ProgressBar
      ranges={{
        good: [0.75, 1],
        average: [0.25, 0.75],
        bad: [0, 0.25],
      }}
      value={mission.remaining / mission.duration}
    />
  );

  const missionJSX = missionsArray.map((mission: Mission) => {
    const {
      ref,
      name,
      author,
      desc,
      reward,
      faction,
      location,
      timeIssued,
      actStr,
      duration,
      canTurnIn,
      validItems,
      claim,
    } = mission;
    return (
      <Box key={ref}>
        <LabeledList>
          <LabeledList.Divider />
          <LabeledList.Item label="Title">{name}</LabeledList.Item>
          <LabeledList.Item label="Cords">{location}</LabeledList.Item>
          <LabeledList.Item label="Author">{author}</LabeledList.Item>
          <LabeledList.Item label="Faction">{faction}</LabeledList.Item>
          <LabeledList.Item label="Description">{desc}</LabeledList.Item>
          <LabeledList.Item label="Time">
            <Box>Issued: {timeIssued} minutes ago.</Box>
            {duration && <Box>Duration Left: {missionTimer(mission)}</Box>}
          </LabeledList.Item>
          <LabeledList.Item label="Rewards">{reward}</LabeledList.Item>
          {pad ? (
            <LabeledList.Item label="Turn In">
              <LabeledList.Divider />
              {validItems.map((validItem: string) => (
                <Box key={validItem}>{validItem}</Box>
              ))}
            </LabeledList.Item>
          ) : null}
          <LabeledList.Item>
            <Button
              tooltip={'An informal system of claiming missions.'}
              onClick={() => act('claim', { mission: ref })}
            >
              {'>Claim: ' + claim}
            </Button>
            <Button
              icon={'arrow-up'}
              tooltip={'Turn in mission. Requires an ID'}
              disabled={!canTurnIn || !pad || !id_inserted}
              onClick={() => act('send', { mission: ref })}
            >
              {actStr}
            </Button>
          </LabeledList.Item>
        </LabeledList>
      </Box>
    );
  });

  return <Box>{missionJSX}</Box>;
};
