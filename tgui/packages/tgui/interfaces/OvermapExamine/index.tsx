import { useBackend, useLocalState } from '../../backend';

import {
  Button,
  Box,
  Divider,
  Flex,
  Icon,
  Input,
  Section,
  LabeledList,
  ProgressBar,
  AnimatedNumber,
} from '../../components';
import { ButtonInput } from '../../components/Button';
import { Window } from '../../layouts';

export type OvermapData = {
  ref: string;
  name: string;
  ascii: string;
  desc: string;
  x: number;
  y: number;
  dockedTo: TokenData;
  docked: TokenData[];
  active_missions: MissionData[] | null;
  inactive_missions: MissionData[] | null;
};

export type TokenData = {
  ref: string;
  name: string;
};

export type MissionData = {
  ref: string;
  name: string;
};

export const OvermapExamine = (props, context) => {
  const { act, data } = useBackend<OvermapData>(context);
  const { name, ascii, desc, x, y, dockedTo, docked = [] } = data;

  return (
    <Window title={ascii + '  ' + name} width={400} height={600}>
      <Window.Content scrollable>
        <Section title={name}>
          <LabeledList>
            <LabeledList.Item label="Position">
              X
              <AnimatedNumber value={x} />
              /Y
              <AnimatedNumber value={y} />
            </LabeledList.Item>
            <LabeledList.Item label="Information">{desc}</LabeledList.Item>
            {dockedTo.ref && (
              <LabeledList.Item label="Docked To">
                <Box>
                  {dockedTo.name}{' '}
                  <Button
                    onClick={() =>
                      act('inspect', {
                        ref: dockedTo.ref,
                      })
                    }
                  >
                    Inspect
                  </Button>
                </Box>
              </LabeledList.Item>
            )}
            {docked.length != 0 && (
              <LabeledList.Item label="Docked">
                {docked.map((docked_datum) => (
                  <Box>
                    {docked_datum.name}{' '}
                    <Button
                      onClick={() =>
                        act('inspect', {
                          ref: docked_datum.ref,
                        })
                      }
                    >
                      Inspect
                    </Button>
                  </Box>
                ))}
              </LabeledList.Item>
            )}
            <LabeledList.Item label="Active Missions">
              {data.active_missions?.map((mission) => (
                <Box>{mission.name}</Box>
              ))}
            </LabeledList.Item>
            <LabeledList.Item label="Inactive Missions">
              {data.inactive_missions?.map((mission) => (
                <Box>{mission.name}</Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
