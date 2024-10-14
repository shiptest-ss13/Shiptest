import { NtosWindow } from '../layouts';
import { MissionsContent } from './MissionBoard';

export const NtosMission = () => {
  return (
    <NtosWindow width={370} height={400} resizable>
      <NtosWindow.Content scrollable>
        <MissionsContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
