import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, Section, ProgressBar } from '../components';
import { BeakerContents } from './common/BeakerContents';

export const Cloner = props => {
  const { act, data } = useBackend(props);

  return (
    <Fragment>
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
    </Fragment>
  );
};
