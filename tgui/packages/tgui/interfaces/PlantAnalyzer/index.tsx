import { useBackend } from '../../backend';
import {
  ProgressBar,
  Button,
  Section,
  Stack,
  AnimatedNumber,
  Tooltip,
  Box,
} from '../../components';
import { Window } from '../../layouts';

import { capitalizeFirst } from 'common/string';

import { PLANTSTATUS2COLOR } from './constants';

import { PlantAnalyzerData } from './types';

export const PlantAnalyzer = (props, context) => {
  const { act, data } = useBackend<PlantAnalyzerData>(context);
  const { tray, seed } = data;
  return (
    <Window width={500} height={600} resizable>
      <Window.Content scrollable>
        {tray.name && <TrayContent />}
        {seed.name && <SeedContent />}
      </Window.Content>
    </Window>
  );
};

const TrayContent = (props, context) => {
  const { act, data } = useBackend<PlantAnalyzerData>(context);
  const { tray } = data;
  return (
    <Section title="Tray">
      <Stack vertical fill>
        <Stack.Item>
          Plant Status:{' '}
          <Button backgroundColor={PLANTSTATUS2COLOR[tray.status]}>
            {capitalizeFirst(tray.status)}
          </Button>
        </Stack.Item>
        <Stack fill>
          <Stack.Item style={{ width: '50%' }}>
            Water:
            <Level value={tray.water} max={tray.maxwater} />
          </Stack.Item>
          <Stack.Item style={{ width: '50%' }}>
            Nutrients:
            <Level value={tray.nutrients} max={tray.maxnutri} />
          </Stack.Item>
        </Stack>
        <Stack fill>
          <Stack.Item style={{ width: '33%' }}>
            Weeds:
            <Level value={tray.weeds} max={10} reverse />
          </Stack.Item>
          <Stack.Item style={{ width: '33%' }}>
            Pests:
            <Level value={tray.pests} max={10} reverse />
          </Stack.Item>
          <Stack.Item style={{ width: '33%' }}>
            Toxic:
            <Level value={tray.toxic} max={100} reverse />
          </Stack.Item>
        </Stack>
        <Stack.Item>
          Plant Age: <AnimatedNumber value={tray.age} />
        </Stack.Item>
        <Stack.Item>
          Self-Sustaining: {tray.self_sustaining ? 'Yes' : 'No'}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const SeedContent = (props, context) => {
  const { act, data } = useBackend<PlantAnalyzerData>(context);
  const { seed } = data;
  return (
    <Section title={seed.name}>
      <Stack vertical fill>
        <Stack fill>
          <Stack.Item style={{ width: '20%' }}>
            <LevelWithTooltip
              name="Potency: "
              value={seed.potency}
              max={100}
              tooltip="Potency: Determines product mass, reagent volume and strength of effects."
            />
          </Stack.Item>
          <Stack.Item style={{ width: '20%' }}>
            <LevelWithTooltip
              name="Yield: "
              value={seed.yield}
              max={10}
              tooltip="Yield: The number of products gathered in a single harvest."
            />
          </Stack.Item>
          <Stack.Item style={{ width: '20%' }}>
            <LevelWithTooltip
              name="Endurance: "
              value={seed.endurance}
              max={100}
              tooltip="Endurance: The health pool of the plant that delays death."
            />
          </Stack.Item>
          <Stack.Item style={{ width: '20%' }}>
            <LevelWithTooltip
              name="Lifespan: "
              value={seed.lifespan}
              max={100}
              tooltip={`Lifespan: The age at which the plant starts decaying, in ${data.cycle_seconds} second long cycles. Improves quality of resulting food & drinks.`}
            />
          </Stack.Item>
          <Stack.Item style={{ width: '20%' }}>
            <LevelWithTooltip
              name="Instability: "
              value={seed.instability}
              max={100}
              tooltip={`Instability: The likelihood of the plant to randomize stats or mutate. Affects quality of resulting food & drinks.`}
            />
          </Stack.Item>
        </Stack>
        <Stack.Item>
          <Tooltip
            content={`Maturation: The age required for the first harvest, in ${data.cycle_seconds} second long cycles.`}
          >
            <Box>
              Maturation Speed: <AnimatedNumber value={seed.maturation} />
            </Box>
          </Tooltip>
        </Stack.Item>
        <Stack.Item>
          <Tooltip
            content={`Production: The period of product regrowth, in ${data.cycle_seconds} second long cycles.`}
          >
            <Box>
              Production Speed: <AnimatedNumber value={seed.production} />
            </Box>
          </Tooltip>
        </Stack.Item>
        <Stack.Item>
          Weed Rate: <AnimatedNumber value={seed.weed_rate} />
        </Stack.Item>
        <Stack.Item>
          Weed Chance: <AnimatedNumber value={seed.weed_chance} />
        </Stack.Item>
        <Stack.Item>
          Species Discovery Value: <AnimatedNumber value={seed.rarity} />
        </Stack.Item>
        <Stack.Item>
          {seed.genes && seed.genes.length > 0 && (
            <Section title="Genes">
              {seed.genes?.map((trait, index) => (
                <Genetic key={index} path={trait} trait_db={data.trait_db} />
              ))}
            </Section>
          )}
        </Stack.Item>
        <Stack.Item>
          {seed.mutatelist && seed.mutatelist.length > 0 && (
            <Section title="Mutations">
              {seed.mutatelist?.map((mutation, index) => (
                <Tooltip key={index} content={mutation.desc}>
                  <Box index={index}>
                    {mutation.name}
                    <Button
                      icon="magnifying-glass"
                      onClick={() =>
                        act('investigate_plant', {
                          mutation_type: mutation.type,
                        })
                      }
                      tooltip="Investigate"
                    >
                      ?
                    </Button>
                  </Box>
                </Tooltip>
              ))}
            </Section>
          )}
        </Stack.Item>
      </Stack>
      <Section title="Reagents">
        <Stack vertical fill>
          {seed.grind_results && seed.grind_results.length > 0 && (
            <Section>
              {seed.grind_results.map((result, index) => (
                <Tooltip key={index} content={result.desc}>
                  <Stack.Item key={index}>
                    {result.name}: {result.amount}
                  </Stack.Item>
                </Tooltip>
              ))}
            </Section>
          )}
          {seed.distill_reagent && (
            <Section title="Distillation Reagent">
              <Stack.Item>{seed.distill_reagent}</Stack.Item>
            </Section>
          )}
          {seed.juice_result && seed.juice_result.length > 0 && (
            <Section title="Juice Results">
              {seed.juice_result.map((result, index) => (
                <Stack.Item key={index}>{result}</Stack.Item>
              ))}
            </Section>
          )}
        </Stack>
      </Section>
    </Section>
  );
};

const Level = (props) => {
  return (
    <ProgressBar
      value={props.value}
      maxValue={props.max}
      ranges={
        props.reverse
          ? {
              good: [0, props.max * 0.2],
              average: [props.max * 0.2, props.max * 0.6],
              bad: [props.max * 0.6, props.max],
            }
          : {
              bad: [0, props.max * 0.2],
              good: [props.max * 0.8, props.max],
            }
      }
    >
      <AnimatedNumber value={props.value} />
      {' / '}
      {props.max}
    </ProgressBar>
  );
};

const LevelWithTooltip = (props) => {
  return (
    <Tooltip content={props.tooltip}>
      <Box>
        {props.name}
        <Level value={props.value} max={props.max} />
      </Box>
    </Tooltip>
  );
};

const Genetic = (props) => {
  const trait = props.trait_db.find((t) => {
    return t.path === props.path;
  });
  return (
    <Tooltip content={trait.description}>
      <Box key={props.index}>{trait.name}</Box>
    </Tooltip>
  );
};
