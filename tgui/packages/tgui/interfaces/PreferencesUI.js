import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const PreferencesUI = (props, context) => {
  const { act, data } = useBackend(context);
  // Extract `health` and `color` variables from the `data` object.
  const { hair, color } = data;
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Simple Hair Menu">
          <LabeledList>
            <LabeledList.Item label="Hair Type">{hair}</LabeledList.Item>
            <LabeledList.Item label="Hair Color">{color}</LabeledList.Item>
            <LabeledList.Item label="Randomizer">
              <Button
                content="Randomize your hair color, why it ourple :skull:"
                onClick={() => act('test')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
