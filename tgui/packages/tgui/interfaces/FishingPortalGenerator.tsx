import { Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type FishingPortalData = {
  active: boolean;
  presets: string[];
  active_preset: string;
};

export const FishingPortalGenerator = (props) => {
  const { act, data } = useBackend<FishingPortalData>();

  return (
    <Window title="Ishmael3000" width={300} height={300}>
      <Window.Content>
        <Section>
          {!data.active && (
            <LabeledList>
              {data.presets.map((x) => (
                <LabeledList.Item key={x}>
                  <Button
                    disabled={data.active}
                    onClick={() => act('preset', { preset: x })}
                    content={x}
                    selected={x === data.active_preset}
                  />
                </LabeledList.Item>
              ))}
            </LabeledList>
          )}
          <Button
            content={(data.active && 'Deactivate') || 'Activate'}
            onClick={() => data.active && act('toggle')}
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
