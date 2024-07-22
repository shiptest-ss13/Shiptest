import { useBackend } from '../../backend';
import {
  Blink,
  Box,
  Button,
  Dimmer,
  Flex,
  RestrictedInput,
  Icon,
  Input,
  Modal,
  Section,
  Tabs,
  Table,
} from '../../components';
import { TableCell, TableRow } from '../../components/Table';
import { Window } from '../../layouts';
import { formatMoney } from '../../format';

import { CargoData, SupplyPack } from './types';

export const CargoCart = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [], shopping_cart = [] } = data;

  let total = 0;
  let count = 0;
  for (let i = 0; i < shopping_cart.length; i++) {
    count += shopping_cart[i].count;
    total += shopping_cart[i].cost;
  }

  return (
    <Section title="Cart" fill scrollable>
      <Table>
        <TableRow header color="gray">
          <Table.Cell>Item</Table.Cell>
          <Table.Cell>Cost</Table.Cell>
          <Table.Cell>Count</Table.Cell>
        </TableRow>
        {shopping_cart.map((request) => (
          <Table.Row key={request.ref} className="candystripe" color="label">
            <Table.Cell wrap>{request.name}</Table.Cell>
            <Table.Cell>{formatMoney(request.cost)}</Table.Cell>
            <Table.Cell>
              <RestrictedInput
                width={3}
                minValue={0}
                value={request.count}
                onEnter={(e, value) =>
                  act('modify', {
                    ref: request.ref,
                    amount: value,
                  })
                }
              ></RestrictedInput>
              <Button
                icon="minus"
                onClick={() => act('remove', { ref: request.ref })}
              />
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Flex>
        <Button
          color="yellow"
          content="Withdraw Cash"
          onClick={() => act('withdraw')}
        />
        <Button
          icon="shopping-cart"
          color="good"
          content="Buy"
          onClick={() => act('buy')}
        >
          {' '}
          {count}
        </Button>
        <Button
          icon="times"
          color="transparent"
          content="Clear"
          onClick={() => act('clear')}
        >
          {' '}
          {count}
        </Button>
      </Flex>
      <Flex>
        <Button>Cash: 111111</Button>
        <Button>Total cost: {total}</Button>
      </Flex>
    </Section>
  );
};
