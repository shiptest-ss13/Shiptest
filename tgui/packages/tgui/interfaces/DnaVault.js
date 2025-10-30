import {
  Box,
  Button,
  Flex,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const DnaVault = (props) => {
  const { act, data } = useBackend();
  const {
    completed,
    used,
    choiceA,
    choiceB,
    dna,
    dna_max,
    plants,
    plants_max,
    animals,
    animals_max,
  } = data;
  return (
    <Window width={350} height={400}>
      <Window.Content>
        <Section title="DNA Vault Database">
          <LabeledList>
            <LabeledList.Item label="Human DNA">
              <ProgressBar value={dna / dna_max}>
                {dna + ' / ' + dna_max + ' Samples'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Plant DNA">
              <ProgressBar value={plants / plants_max}>
                {plants + ' / ' + plants_max + ' Samples'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Animal DNA">
              <ProgressBar value={animals / animals}>
                {animals + ' / ' + animals_max + ' Samples'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        {!!(completed && !used) && (
          <Section title="Personal Gene Therapy">
            <Box bold textAlign="center" mb={1}>
              Applicable Gene Therapy Treatments
            </Box>
            <Flex>
              <Flex.Column>
                <Button
                  fluid
                  bold
                  content={choiceA}
                  textAlign="center"
                  onClick={() =>
                    act('gene', {
                      choice: choiceA,
                    })
                  }
                />
              </Flex.Column>
              <Flex.Column>
                <Button
                  fluid
                  bold
                  content={choiceB}
                  textAlign="center"
                  onClick={() =>
                    act('gene', {
                      choice: choiceB,
                    })
                  }
                />
              </Flex.Column>
            </Flex>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
