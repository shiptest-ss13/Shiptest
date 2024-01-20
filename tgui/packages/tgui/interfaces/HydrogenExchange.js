import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const HydrogenExchange = (props, context) => {
  const { act, data } = useBackend(context);
  const { credits, merits, next_merit_rate, credits_to_merits, credit_tax } =
    data;
  return (
    <Window
      title="Hydrogen Exchange"
      theme="ntos_terminal"
      width={400}
      height={250}
    >
      <Window.Content>
        <Section
          title={
            'Current credits: ' + credits + ', conversion rate is ' + credit_tax
          }
        />
        <Section
          title={
            'Current merits: ' +
            merits +
            ', the next merit rate is ' +
            next_merit_rate +
            'cr'
          }
        />
        <Section
          title={'Exchange Rate: ' + credits_to_merits + ' credits per merit.'}
        >
          <LabeledList>
            <LabeledList.Item
              label="Convert credits to merits"
              buttons={
                <Button
                  icon="sync"
                  content="Convert to merits"
                  onClick={() => act('convert_to_merits')}
                />
              }
            />
            <LabeledList.Item
              label="Convert merits to credits"
              buttons={
                <Button
                  icon="sync"
                  content="Convert to credits"
                  onClick={() => act('convert_to_credits')}
                />
              }
            />
            <LabeledList.Item
              label="Dispense Merits and Credits"
              buttons={
                <Button
                  icon="sync"
                  content="Dispense"
                  onClick={() => act('dispense')}
                />
              }
            />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
