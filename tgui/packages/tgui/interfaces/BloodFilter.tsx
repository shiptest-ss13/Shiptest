import { Stack } from '../components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { ChemFilterPane } from './ChemFilter';

type Data = {
  whitelist: string[];
};

export const BloodFilter = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { whitelist = [] } = data;

  return (
    <Window width={500} height={300}>
      <Window.Content scrollable>
        <Stack>
          <Stack.Item grow>
            <ChemFilterPane
              title="Whitelist"
              list={whitelist}
              buttonColor="green"
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
