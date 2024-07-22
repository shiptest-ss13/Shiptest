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
import { Window } from '../../layouts';

import { CargoData, SupplyPack } from './types';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [] } = data;
  return (
    <Section title="Catalog" fill scrollable>
      <Flex>
        <Section>
          <Input></Input>
          <Tabs vertical>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
            <Tabs.Tab>GUNS 111</Tabs.Tab>
          </Tabs>
        </Section>
        <Table>
          <Table.Row header>
            <Table.Cell>Name</Table.Cell>
            <Table.Cell>Cost</Table.Cell>
          </Table.Row>
          {supply_packs.map((supply) => (
            <Table.Row key={supply.name} className="candystripe">
              <Table.Cell>{supply.name}</Table.Cell>
              <Table.Cell>{supply.cost}</Table.Cell>
            </Table.Row>
          ))}
        </Table>
      </Flex>
    </Section>
  );
};
