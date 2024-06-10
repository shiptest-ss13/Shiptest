import { useBackend } from '../backend';
import {
  ProgressBar,
  Section,
  Stack,
  AnimatedNumber,
  Tooltip,
  Box,
} from '../components';
import { Window } from '../layouts';

type Data = {
  scan_target: string;
  tray: TrayData;
  seed: SeedData;
  product: ProductData;
  cycle_seconds: number;
  trait_db: TraitData[];
};

type TraitData = {
  path: string;
  name: string;
  description: string;
};

type TrayData = {
  name: string;
  weeds: number;
  pests: number;
  toxic: number;
  water: number;
  maxwater: number;
  nutrients: number;
  maxnutri: number;
  age: number;
  dead: boolean;
  harvest: boolean;
  self_sustaining: boolean;
};

type SeedData = {
  name: number;
  lifespan: number;
  endurance: number;
  maturation: number;
  production: number;
  yield: number;
  potency: number;
  instability: number;
  weed_rate: number;
  weed_chance: number;
  rarity: number;
  genes: string[];
  mutatelist: string[];
};

type ProductData = {
  name: string;
  distill_reagent: string;
  juice_result: [];
  grind_results: ReagentData[];
};

type ReagentData = {
  name: string;
  desc: string;
  amount: number;
};

export const PlantAnalyzer = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { tray, seed, product } = data;
  return (
    <Window width={500} height={600} resizable>
      <Window.Content scrollable>
        {tray.name ? (
          <TrayContent />
        ) : (
          <Section title="No Tray">
            <Stack vertical fill>
              <Stack.Item>No tray data available.</Stack.Item>
            </Stack>
          </Section>
        )}
        {seed.name ? (
          <SeedContent />
        ) : (
          <Section title="No Seed">
            <Stack vertical fill>
              <Stack.Item>No seed data available.</Stack.Item>
            </Stack>
          </Section>
        )}
        {product.name ? (
          <ProductContent />
        ) : (
          <Section title="No Product">
            <Stack vertical fill>
              <Stack.Item>No product data available.</Stack.Item>
            </Stack>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const TrayContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { tray, seed, product } = data;
  return (
    <Section title="Tray">
      <Stack vertical fill>
        <Stack fill>
          <Stack.Item style="width 50%">
            Water:
            <Level value={tray.water} max={tray.maxwater}></Level>
          </Stack.Item>
          <Stack.Item style="width 50%">
            Nutrients:
            <Level value={tray.nutrients} max={tray.maxnutri}></Level>
          </Stack.Item>
        </Stack>
        <Stack fill>
          <Stack.Item style="width 33%">
            Weeds:
            <Level value={tray.weeds} max={10} reverse></Level>
          </Stack.Item>
          <Stack.Item style="width 33%">
            Pests:
            <Level value={tray.pests} max={10} reverse></Level>
          </Stack.Item>
          <Stack.Item style="width 33%">
            Toxic:
            <Level value={tray.toxic} max={100} reverse></Level>
          </Stack.Item>
        </Stack>
        <Stack.Item>
          Plant Age: <AnimatedNumber value={tray.age}></AnimatedNumber>
        </Stack.Item>
        <Stack.Item>Status: {tray.dead ? 'Yes' : 'No'}</Stack.Item>
        <Stack.Item>Harvest: {tray.harvest ? 'Yes' : 'No'}</Stack.Item>
        <Stack.Item>
          Self-Sustaining: {tray.self_sustaining ? 'Yes' : 'No'}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const SeedContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { seed } = data;
  return (
    <Section title={seed.name}>
      <Stack vertical fill>
        <Stack fill>
          <Stack.Item style="width 20%">
            <LevelWithTooltip
              name="Potency: "
              value={seed.potency}
              max={100}
              tooltip="Potency: Determines product mass, reagent volume and strength of effects."
            />
          </Stack.Item>
          <Stack.Item style="width 20%">
            <LevelWithTooltip
              name="Yield: "
              value={seed.yield}
              max={10}
              tooltip="Yield: The number of products gathered in a single harvest."
            />
          </Stack.Item>
          <Stack.Item style="width 20%">
            <LevelWithTooltip
              name="Endurance: "
              value={seed.endurance}
              max={100}
              tooltip="Endurance: The health pool of the plant that delays death."
            />
          </Stack.Item>
          <Stack.Item style="width 20%">
            <LevelWithTooltip
              name="Lifespan: "
              value={seed.lifespan}
              max={100}
              tooltip={`Lifespan: The age at which the plant starts decaying, in ${data.cycle_seconds} second long cycles. Improves quality of resulting food & drinks.`}
            />
          </Stack.Item>
          <Stack.Item style="width 20%">
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
              Maturation Speed:{' '}
              <AnimatedNumber value={seed.maturation}></AnimatedNumber>
            </Box>
          </Tooltip>
        </Stack.Item>
        <Stack.Item>
          <Tooltip
            content={`Production: The period of product regrowth, in ${data.cycle_seconds} second long cycles.`}
          >
            <Box>
              Production Speed:{' '}
              <AnimatedNumber value={seed.production}></AnimatedNumber>
            </Box>
          </Tooltip>
        </Stack.Item>
        <Stack.Item>
          Weed Rate: <AnimatedNumber value={seed.weed_rate}></AnimatedNumber>
        </Stack.Item>
        <Stack.Item>
          Weed Chance:{' '}
          <AnimatedNumber value={seed.weed_chance}></AnimatedNumber>
        </Stack.Item>
        <Stack.Item>
          Species Discovery Value:{' '}
          <AnimatedNumber value={seed.rarity}></AnimatedNumber>
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
                <Box index={index}> {mutation} </Box>
              ))}
            </Section>
          )}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const ProductContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { product } = data;
  return (
    <Section title={product.name}>
      <Stack vertical fill>
        {product.distill_reagent && (
          <Stack.Item>
            Distillation Reagent: {product.distill_reagent}
          </Stack.Item>
        )}
        {product.juice_result && product.juice_result.length > 0 && (
          <Section title="Juice Results">
            {product.juice_result.map((result, index) => (
              <Stack.Item key={index}>{result}</Stack.Item>
            ))}
          </Section>
        )}
        {product.grind_results && product.grind_results.length > 0 && (
          <Section title="Grind Results">
            {product.grind_results.map((result, index) => (
              <Tooltip content={result.desc}>
                <Stack.Item key={index}>
                  {result.name}: {result.amount}
                </Stack.Item>
              </Tooltip>
            ))}
          </Section>
        )}
      </Stack>
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
      <AnimatedNumber
        style={{
          textShadow: '1px 1px 0 black',
        }}
        value={props.value}
      ></AnimatedNumber>
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
        <Level value={props.value} max={props.max}></Level>
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
