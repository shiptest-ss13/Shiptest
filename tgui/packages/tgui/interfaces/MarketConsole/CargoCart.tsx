import { useBackend } from '../../backend';
import { Box, Button, RestrictedInput, Section, Table } from '../../components';
import { TableRow } from '../../components/Table';
import { formatMoney } from '../../format';

import { CargoData } from './types';

export const CargoCart = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const {
    supply_packs = [],
    account_holder,
    account_balance,
    shopping_cart = [],
  } = data;

  let total = 0;
  let count = 0;
  for (let i = 0; i < shopping_cart.length; i++) {
    count += shopping_cart[i].count;
    total += shopping_cart[i].cost * shopping_cart[i].count;
  }

  return (
    <Section title="Cart">
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
            <Button>
              {`${account_holder}: ${formatMoney(account_balance)} cr`}
            </Button>
          </Table.Cell>
          <Table.Cell>
            <Box>{`Total cost: ${formatMoney(total)} cr`}</Box>
          </Table.Cell>
          <Table.Cell>
            <Button
              icon="shopping-cart"
              color="good"
              onClick={() => act('buy')}
            >
              {'Buy '}
              {count}
            </Button>
            <Button
              icon="times"
              color="transparent"
              onClick={() => act('clear')}
            >
              {'Clear '}
              {count}
            </Button>
          </Table.Cell>
        </TableRow>
      </Table>
    </Section>
  );
};
