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

import { CargoData, SupplyPack } from './types';

export const CargoCart = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [], cart = [] } = data;
  return (
    <Section title="Cart" width={'35%'} fill scrollable>
      <Table>
        <TableRow header color="gray">
          <Table.Cell>Item</Table.Cell>
          <Table.Cell>Cost</Table.Cell>
          <Table.Cell>Count</Table.Cell>
        </TableRow>
        {supply_packs.map((request) => (
          <Table.Row key={request.id} className="candystripe" color="label">
            <Table.Cell wrap>{request.name}</Table.Cell>
            <Table.Cell>{request.cost}</Table.Cell>
            <Table.Cell>
              <RestrictedInput width={3} minValue={0}></RestrictedInput>
            </Table.Cell>
          </Table.Row>
        ))}
          <Table.Row>
            <Table.Cell>BUY</Table.Cell>
            <Table.Cell>COST:1000000</Table.Cell>
            <Table.Cell>COUNT:1000000</Table.Cell>
          </Table.Row>
      </Table>
    </Section>
  );
};
