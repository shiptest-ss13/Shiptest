import { useBackend, useSharedState } from '../../backend';
import {
  ProgressBar,
  Section,
  Tabs,
  Button,
  LabeledList,
  Box,
  Stack,
} from '../../components';
import { Window } from '../../layouts';

import { CargoCatalog } from './Catalog';
import { Data } from './types';

export const OutpostCommunications = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { outpostDocked, onShip, points } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <Section
          title={Math.round(points) + ' credits'}
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
              <Stack.Item>
                <Button.Input
                  content="Withdraw Cash"
                  currentValue={100}
                  defaultValue={100}
                  onCommit={(e, value) =>
                    act('withdrawCash', {
                      value: value,
                    })
                  }
                />
              </Stack.Item>
            </Stack>
          }
        />
        {tab === 'cargo' && <CargoExpressContent />}
      </Window.Content>
    </Window>
  );
};

const CargoExpressContent = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    beaconZone,
    beaconName,
    hasBeacon,
    usingBeacon,
    printMsg,
    canBuyBeacon,
    message,
  } = data;
  return (
    <>
      <Section title="Cargo Express">
        <LabeledList>
          <LabeledList.Item label="Landing Location">
            <Button
              content="Cargo Bay"
              selected={!usingBeacon}
              onClick={() => act('LZCargo')}
            />
            <Button
              selected={usingBeacon}
              disabled={!hasBeacon}
              onClick={() => act('LZBeacon')}
            >
              {beaconZone} ({beaconName})
            </Button>
            <Button
              content={printMsg}
              disabled={!canBuyBeacon}
              onClick={() => act('printBeacon')}
            />
          </LabeledList.Item>
          <LabeledList.Item label="Notice">{message}</LabeledList.Item>
        </LabeledList>
      </Section>
      <CargoCatalog />
    </>
  );
};
