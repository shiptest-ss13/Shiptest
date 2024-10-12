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
  x: number;
  y: number;
  dockedTo: TokenData;
  docked: TokenData[];
};

export type TokenData = {
  ref: string;
  name: string;
};

export const OvermapExamine = (props, context) => {
  const { act, data } = useBackend<OvermapData>(context);
  const { name, ascii, x, y, dockedTo, docked = []} = data;

  return (
    <Window title={ascii + '  ' + name} width={350} height={700}>
      <Window.Content scrollable>
        <Section title={name}>
          <LabeledList>
            <LabeledList.Item label="Position">
              X
              <AnimatedNumber value={x} />
              /Y
              <AnimatedNumber value={y} />
            </LabeledList.Item>
            <LabeledList.Item label="Docked To">
              <Box>
              {dockedTo.name} <Button>Inspect</Button>
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Docked">
              {docked.map((docked_datum) => (
                <Box>
                  {docked_datum.name} <Button>Inspect</Button>
                </Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
