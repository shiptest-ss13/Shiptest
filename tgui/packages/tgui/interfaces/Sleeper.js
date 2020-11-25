import { useBackend } from '../backend';
import { AnimatedNumber, Box, Section, LabeledList, Button, ProgressBar } from '../components';
import { Fragment } from 'inferno';
import { Window } from '../layouts';
import { sortBy } from 'common/collections';
import { toFixed } from 'common/math';

const damageTypes = [
  {
    label: 'Brute',
    type: 'bruteLoss',
  },
  {
    label: 'Burn',
    type: 'fireLoss',
  },
  {
    label: 'Toxin',
    type: 'toxLoss',
  },
  {
    label: 'Oxygen',
    type: 'oxyLoss',
  },
];

export const Sleeper = (props, context) => {
  const { act, data } = useBackend(context);
  const chemicals = sortBy(chem => chem.title)(data.chemicals);
  const transferAmounts = data.transferAmounts || [];
  const {
    open,
    occupant = {},
    occupied,
    stasis,
    canStasis,
    cell = {},
  } = data;
  return (
    <Window
      width={495}
      height={550}
      resizable>
      <Window.Content scrollable>
        <Section
          title={occupant.name ? occupant.name : 'No Occupant'}
          minHeight="210px"
          buttons={!!occupied && !!canStasis && (
            <Button
              onClick={() => act('toggleStasis')}
              color={stasis && 'good'}
              content={"Toggle Stasis"} />
          ) || !!occupant.stat && (
            <Box
              inline
              bold
              color={occupant.statstate}>
              {occupant.stat}
            </Box>
          )}>
          {!!occupied && (
            <Fragment>
              <ProgressBar
                value={occupant.health}
                minValue={occupant.minHealth}
                maxValue={occupant.maxHealth}
                ranges={{
                  good: [50, Infinity],
                  average: [0, 50],
                  bad: [-Infinity, 0],
                }} />
              <Box mt={1} />
              <LabeledList>
                {damageTypes.map(type => (
                  <LabeledList.Item
                    key={type.type}
                    label={type.label}>
                    <ProgressBar
                      value={occupant[type.type]}
                      minValue={0}
                      maxValue={occupant.maxHealth}
                      color="bad" />
                  </LabeledList.Item>
                ))}
                {!!canStasis && !!occupant.stat && (
                  <LabeledList.Item
                    label="Status"
                    color={occupant.statstate}>
                    {occupant.stat}
                  </LabeledList.Item>
                )}
                <LabeledList.Item
                  label="Cells"
                  color={occupant.cloneLoss ? 'bad' : 'good'}>
                  {occupant.cloneLoss ? 'Damaged' : 'Healthy'}
                </LabeledList.Item>
                <LabeledList.Item
                  label="Brain"
                  color={occupant.brainLoss ? 'bad' : 'good'}>
                  {occupant.brainLoss ? 'Abnormal' : 'Healthy'}
                </LabeledList.Item>
                <LabeledList.Item label="Reagents">
                  <Box color="label">
                    {occupant.reagents.length === 0 && '—'}
                    {occupant.reagents.map(chemical => (
                      <Box key={chemical.name}>
                        <AnimatedNumber
                          value={chemical.volume}
                          format={value => toFixed(value, 1)} />
                        {` units of ${chemical.name}`}
                      </Box>
                    ))}
                  </Box>
                </LabeledList.Item>
              </LabeledList>
            </Fragment>
          )}
        </Section>
        <Section
          title="Inject"
          buttons={(
            transferAmounts.map(amount => (
              <Button
                key={amount}
                icon="plus"
                selected={amount === data.amount}
                content={amount}
                onClick={() => act('amount', {
                  target: amount,
                })} />
            ))
          )}>
          <Box mr={-1}>
            {chemicals.map(chemical => (
              <Button
                key={chemical.id}
                icon="tint"
                width="150px"
                lineHeight="21px"
                disabled={!(occupied && chemical.allowed)}
                content={`(${chemical.volume}) ${chemical.title}`}
                onClick={() => act('inject', {
                  reagent: chemical.id,
                })} />
            ))}
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};


