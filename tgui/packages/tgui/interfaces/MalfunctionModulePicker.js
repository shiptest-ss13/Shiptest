import { useBackend } from '../backend';
import { Window } from '../layouts';
import { GenericUplink } from './Uplink';

export const MalfunctionModulePicker = (props) => {
  const { act, data } = useBackend();
  const { processingTime } = data;
  return (
    <Window width={620} height={525} theme="malfunction">
      <Window.Content scrollable>
        <GenericUplink currencyAmount={processingTime} currencySymbol="PT" />
      </Window.Content>
    </Window>
  );
};
