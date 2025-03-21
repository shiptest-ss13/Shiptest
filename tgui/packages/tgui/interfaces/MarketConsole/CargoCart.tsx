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
    total += shopping_cart[i].cost * shopping_cart[i].count;
  }

  return (
    <Section title="Cart" scrollable>
      <Table>
        <TableRow header color="gray">
          <Table.Cell>Item</Table.Cell>
          <Table.Cell>Cost</Table.Cell>
          <Table.Cell>Count</Table.Cell>
        </TableRow>
        {shopping_cart.map((request) => (
          <Table.Row key={request.ref} className="candystripe" color="label">
            <Table.Cell wrap>{request.name}</Table.Cell>
            <Table.Cell>{formatMoney(request.cost * request.count)}</Table.Cell>
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
              />
              <Button
                icon="minus"
                onClick={() => act('remove', { ref: request.ref })}
              />
            </Table.Cell>
          </Table.Row>
        ))}
        <TableRow color="gray">
          <Table.Cell>
            <Button content="Withdraw Cash" onClick={() => act('withdraw')} />
            <Box>Cash: 111111</Box>
          </Table.Cell>
          <Table.Cell>
            <Box>Total cost: {total}</Box>
          </Table.Cell>
          <Table.Cell>
            <Button
              icon="shopping-cart"
              color="good"
              content="Buy"
              onClick={() => act('buy')}
            >
              {count}
            </Button>
            <Button
              icon="times"
              color="transparent"
              content="Clear"
              onClick={() => act('clear')}
            >
              {count}
            </Button>
          </Table.Cell>
        </TableRow>
      </Table>
    </Section>
  );
};
