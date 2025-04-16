import { useBackend, useSharedState } from '../../backend';
import { Section, Tabs, Stack, Button } from '../../components';
import { Window } from '../../layouts';

import { CargoCart } from './CargoCart';
import { CargoCatalog } from './CargoCatalog';
import { CargoData } from './types';

export const MarketConsole = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [] } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');

  return (
    <Window width={700} height={700} theme="ntos_terminal" resizable>
      <Window.Content scrollable>
        <Section
          title={Math.round(data.account_balance) + ' credits'}
          buttons={
            <Stack textAlign="center">
              <Stack.Item>
                <Tabs>
                  <Tabs.Tab
                    icon="envelope"
                    selected={tab === 'catalog'}
                    onClick={() => setTab('catalog')}
                  >
                    Catalog
                  </Tabs.Tab>
                  <Tabs.Tab
                    icon="shopping-cart"
                    selected={tab === 'cart'}
                    onClick={() => setTab('cart')}
                  >
                    Cart
                  </Tabs.Tab>
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
        {tab === 'catalog' && <CargoCatalog />}
        {tab === 'cart' && <CargoCart />}
      </Window.Content>
    </Window>
  );
};
