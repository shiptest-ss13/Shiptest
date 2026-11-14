import {
  Section,
  Tabs,
  LabeledList,
  Stack,
} from '../components';
import { useBackend } from '../backend';
import { useSharedState } from '../backend';
import { Window } from '../layouts';

import { CargoCatalog } from './OutpostCommunications/Catalog';

export const HandheldCatalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { outpostDocked, onShip, points } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <Section
          title={'Catalog'}
          buttons={
            <Stack textAlign="center">
              <Stack.Item>
                <Tabs>
                  {!!outpostDocked && (
                    <Tabs.Tab
                      selected={tab === 'cargo'}
                      onClick={() => setTab('cargo')}
                    >
                      Cargo
                    </Tabs.Tab>
                  )}
                </Tabs>
              </Stack.Item>
            </Stack>
          }
        />
        {tab === 'cargo' && <CargoExpressContent />}
      </Window.Content>
    </Window>
  );
};

export const CargoExpressContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { message } = data;
  return (
    <>
      <Section title="Cargo Express">
        <LabeledList>
          <LabeledList.Item label="Notice">{message}</LabeledList.Item>
        </LabeledList>
      </Section>
      <CargoCatalog />
    </>
  );
};
