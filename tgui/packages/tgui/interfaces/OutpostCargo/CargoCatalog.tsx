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
  const { supply_packs = [], categories = [] } = data;

  const categoriesWithCount = Object.keys(categories).map((categoryName) => {
    const items = categories[categoryName];
    return { categoryName, items };
  });

  return (
    <Section title="Catalog" fill scrollable>
      <Flex>
        <Section width="30%">
          <Input fluid placeholder="Search..."></Input>
          <Tabs>
            <Tabs.Tab>Catagory</Tabs.Tab>
            <Tabs.Tab>Faction</Tabs.Tab>
          </Tabs>
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
        <Box width="70%">
          <Table>
            <Table.Row header>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Cost</Table.Cell>
              <Table.Cell>Stock</Table.Cell>
            </Table.Row>
            {supply_packs.map((supply) => (
              <Table.Row key={supply.name} className="candystripe">
                <Table.Cell width="70%">{supply.name}</Table.Cell>
                <Table.Cell width="15%">{supply.cost}</Table.Cell>
                <Table.Cell width="15%">1</Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Box>
      </Flex>
    </Section>
  );
};
