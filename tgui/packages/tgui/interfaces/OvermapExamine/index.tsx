import { useBackend, useLocalState } from '../../backend';

import { Window } from '../../layouts';

export type OvermapData = {
  name: string;
  ascii: string;
};

export const OvermapExamine = (props, context) => {
  const { act, data } = useBackend<OvermapData>(context);
  const { name, ascii } = data;
  return (
    <Window title={name} width={350} height={700}>
      <Window.Content scrollable>{ascii}</Window.Content>
    </Window>
  );
};
