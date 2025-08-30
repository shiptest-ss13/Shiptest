import { Button, ProgressBar, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BeakerContents } from './common/BeakerContents';

export const Cloner = (props) => {
  const { act, data } = useBackend();

  return (
    <Window width={200} height={100}>
      <Window.Content>
        <Section
          title="Beaker"
          minheight="50px"
          buttons={
            <Button
              icon="eject"
              disabled={!data.isBeakerLoaded}
              onClick={() => act('ejectbeaker')}
              content="Eject"
            />
          }
        >
          <BeakerContents
            beakerLoaded={data.isBeakerLoaded}
            beakerContents={data.beakerContents}
          />
        </Section>
        <Section title="Progress" minheight="50px">
          <ProgressBar
            value={data.progress}
            content={data.progress + '%'}
            maxValue={100}
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
