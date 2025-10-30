import { sortBy } from 'common/collections';
import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const PortableChemMixer = (props) => {
  const { act, data } = useBackend();
  const recording = !!data.recordingRecipe;
  const beakerTransferAmounts = data.beakerTransferAmounts || [];
  const beakerContents =
    (recording &&
      Object.keys(data.recordingRecipe).map((id) => ({
        id,
        name: toTitleCase(id.replace(/_/, ' ')),
        volume: data.recordingRecipe[id],
      }))) ||
    data.beakerContents ||
    [];
  const chemicals = sortBy((chem) => chem.title)(data.chemicals);
  return (
    <Window width={645} height={550}>
      <Window.Content scrollable>
        <Section
          title="Dispense"
          buttons={beakerTransferAmounts.map((amount) => (
            <Button
              key={amount}
              icon="plus"
              selected={amount === data.amount}
              content={amount}
              onClick={() =>
                act('amount', {
                  target: amount,
                })
              }
            />
          ))}
        >
          <Box mr={-1}>
            {chemicals.map((chemical) => (
              <Button
                key={chemical.id}
                icon="tint"
                width="150px"
                lineHeight="21px"
                content={`(${chemical.volume}) ${chemical.title}`}
                onClick={() =>
                  act('dispense', {
                    reagent: chemical.id,
                  })
                }
              />
            ))}
          </Box>
        </Section>
        <Section
          title="Disposal controls"
          buttons={beakerTransferAmounts.map((amount) => (
            <Button
              key={amount}
              icon="minus"
              disabled={recording}
              content={amount}
              onClick={() => act('remove', { amount })}
            />
          ))}
        >
          <LabeledList>
            <LabeledList.Item
              label="Beaker"
              buttons={
                !!data.isBeakerLoaded && (
                  <Button
                    icon="eject"
                    content="Eject"
                    disabled={!data.isBeakerLoaded}
                    onClick={() => act('eject')}
                  />
                )
              }
            >
              {(recording && 'Virtual beaker') ||
                (data.isBeakerLoaded && (
                  <>
                    <AnimatedNumber
                      initial={0}
                      value={data.beakerCurrentVolume}
                    />
                    /{data.beakerMaxVolume} units
                  </>
                )) ||
                'No beaker'}
            </LabeledList.Item>
            <LabeledList.Item label="Contents">
              <Box color="label">
                {(!data.isBeakerLoaded && !recording && 'N/A') ||
                  (beakerContents.length === 0 && 'Nothing')}
              </Box>
              {beakerContents.map((chemical) => (
                <Box key={chemical.name} color="label">
                  <AnimatedNumber initial={0} value={chemical.volume} /> units
                  of {chemical.name}
                </Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
