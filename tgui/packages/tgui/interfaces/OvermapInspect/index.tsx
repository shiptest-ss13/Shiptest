import { useBackend } from '../../backend';

import {
  Button,
  Box,
  Section,
  LabeledList,
  AnimatedNumber,
} from '../../components';
import { Window } from '../../layouts';

import { decodeHtmlEntities } from 'common/string';

export type OvermapData = {
  admin_rights: Boolean;
  ref: string;
  name: string;
  ascii: string;
  desc: string;
  x: number;
  y: number;
  dockedTo: NameAndRef;
  docked: NameAndRef[];
  active_ruin_missions: NameAndRef[] | null;
  inactive_ruin_missions: NameAndRef[] | null;
};

type NameAndRef = {
  name: string;
  ref: string;
};

export const OvermapInspect = (props, context) => {
  const { act, data } = useBackend<OvermapData>(context);
  const { admin_rights, name, ascii, desc, x, y, dockedTo, docked = [] } = data;

  return (
    <Window
      title={'Overmap Inspect: ' + ascii + '  ' + name}
      width={400}
      height={600}
    >
      <Window.Content scrollable>
        <Section
          title={name}
          buttons={
            admin_rights ? (
              <Button onClick={() => act('load')}>Load</Button>
            ) : null
          }
        >
          <LabeledList>
            <LabeledList.Item label="Position">
              X
              <AnimatedNumber value={x} />
              /Y
              <AnimatedNumber value={y} />
            </LabeledList.Item>
            <LabeledList.Item label="Information">
              {decodeHtmlEntities(desc)}
            </LabeledList.Item>
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
            {docked.length !== 0 && (
              <LabeledList.Item label="Docked">
                {docked.map((docked_datum) => (
                  <Box key={docked_datum.ref}>
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
            {admin_rights ? (
              <>
                <LabeledList.Item label="Active Missions">
                  {data.active_ruin_missions?.map((mission) => (
                    <Box key={mission.ref}>
                      {mission.name}{' '}
                      <Button
                        icon="info "
                        onClick={() =>
                          act('inspect_mission', { ref: mission.ref })
                        }
                      />
                    </Box>
                  ))}
                </LabeledList.Item>
                <LabeledList.Item label="Inactive Missions">
                  {data.inactive_ruin_missions?.map((mission) => (
                    <Box key={mission.ref}>
                      {mission.name}{' '}
                      {admin_rights ? (
                        <Button
                          icon="plus"
                          onClick={() =>
                            act('load_mission', { ref: mission.ref })
                          }
                        />
                      ) : null}
                    </Box>
                  ))}
                </LabeledList.Item>
              </>
            ) : null}
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
