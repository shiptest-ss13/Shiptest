import { useBackend } from '../backend';
import { Button } from '../components';
import { Window } from '../layouts';

type RMD = {
  machine_name;
  machine_interface;
};

export const MainframeInterconnect = (props: any, context: any) => {
  const { act, data } = useBackend<RMD>(context);
  const { machine_name, machine_interface } = data;

  return (
    <Window
      title={`Mainframe Interconnect - ${machine_name}`}
      buttons={<Button />}
    >
      <Window.Content>
        <p>
          It appears that this interface doesn&apos;t exist! Contact your
          nearest Mainframe Technician and inquire about this issue.
        </p>
      </Window.Content>
    </Window>
  );
};
