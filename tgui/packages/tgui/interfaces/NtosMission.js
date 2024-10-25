import { NtosWindow } from '../layouts';
import { MissionsContent } from './MissionBoard';

export const NtosMission = () => {
  return (
    <NtosWindow width={550} height={600} resizable>
      <NtosWindow.Content scrollable>
        <MissionsContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
