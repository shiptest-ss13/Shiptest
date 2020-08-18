import { useBackend } from '../backend';
import { Button, Section, ProgressBar } from '../components';
import { BeakerContents } from './common/BeakerContents';
import { Window } from '../layouts';

export const Cloner = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window
      width={200}
      height={100}>
      <Window.Content>
        <Section
          title="Beaker"
          minheight="50px"
          buttons={(
            <Button
              icon="eject"
              disabled={!data.isBeakerLoaded}
              onClick={() => act('ejectbeaker')}
              content="Eject" />
          )}>
          <BeakerContents
            beakerLoaded={data.isBeakerLoaded}
            beakerContents={data.beakerContents} />
        </Section>
        <Section
          title="Progess"
          minheight="50px">
          <ProgressBar
            value={data.progress}
            content={data.progress + '%'}
            maxValue={100} />
        </Section>
      </Window.Content>
    </Window>
  );
};
