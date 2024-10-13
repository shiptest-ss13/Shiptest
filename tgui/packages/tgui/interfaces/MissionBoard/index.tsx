import { useBackend, useSharedState } from '../../backend';
import {
  ProgressBar,
  Section,
  Button,
  LabeledList,
  Box,
  AnimatedNumber,
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
  const { act, data } = useBackend<Data>(context);
  const { missions, pad, id_inserted, sending } = data;
  return (
    <Section
      title={'Available Missions '}
      buttons={
        <>
          <Button
            icon={'sync'}
            tooltip={'Check Contents'}
            disabled={!pad || !id_inserted}
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
  const { pad, id_inserted, sending } = data;

  const missionTimer = (mission: Mission) => (
    <ProgressBar
      ranges={{
        good: [0.75, 1],
        average: [0.25, 0.75],
        bad: [0, 0.25],
      }}
      value={mission.remaining / mission.duration}
    ></ProgressBar>
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
      x,
      y,
      duration,
      canTurnIn,
      validItems,
    } = mission;
    return (
      <LabeledList>
        <LabeledList.Item label="Title">{name}</LabeledList.Item>
        <LabeledList.Item label="Cords">{location}</LabeledList.Item>
        <LabeledList.Item label="Author">{author}</LabeledList.Item>
        <LabeledList.Item label="Faction">{faction}</LabeledList.Item>
        <LabeledList.Item label="Description">{desc}</LabeledList.Item>
        <LabeledList.Item label="Rewards">
          <Button
            icon={'arrow-up'}
            tooltip={'Choose Reward'}
            disabled={!canTurnIn || !pad || !id_inserted}
            onClick={() => act('send', { mission: ref })}
          >
            {reward}
          </Button>
          <LabeledList.Divider />
          {duration ? missionTimer(mission) : ''}
          <LabeledList.Divider />
          {validItems.map((validItem: string) => (
            <Box>{validItem}</Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Divider />
      </LabeledList>
    );
  });

  return <>{missionJSX}</>;
};
