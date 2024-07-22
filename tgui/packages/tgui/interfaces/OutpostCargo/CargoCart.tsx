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
              ></RestrictedInput>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Flex>
        <Button>Withdraw Cash</Button>
        <Box>Cash: 111111</Box>
        <Button>Buy</Button>
      </Flex>
    </Section>
  );
};
