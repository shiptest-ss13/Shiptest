import { useBackend, useSharedState } from '../../backend';
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

import { CargoData, SupplyPack, Category } from './types';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [] } = data;

  const [catagory, setCatagory] = useSharedState(context, 'catagory', '');

  const CategoryTabs = () => {
    return (
      <Tabs vertical>
        {Object.keys(data.categories).map((categoryName) => (
          <Tabs.Tab
            key={categoryName}
            selected={catagory === categoryName}
            onClick={() => setCatagory(categoryName)}
          >{`${categoryName} ${data.categories[categoryName].length}`}</Tabs.Tab>
        ))}
      </Tabs>
    );
  };

  return (
    <Section title="Catalog" fill scrollable>
      <Flex>
        <Section width="30%">
          <Input fluid placeholder="Search..."></Input>
          <Tabs>
            <Tabs.Tab>Catagory</Tabs.Tab>
            <Tabs.Tab>Faction</Tabs.Tab>
          </Tabs>
          <CategoryTabs />
        </Section>
        <Box width="70%">
          <Table>
            <Table.Row header>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Cost</Table.Cell>
              <Table.Cell>Stock</Table.Cell>
            </Table.Row>
            {Object.keys(supply_packs).map((ref) => {
              const supply = supply_packs[ref]; // Lookup once
              return (
                <Table.Row key={supply.ref} className="candystripe">
                  <Table.Cell width="70%">{supply.name}</Table.Cell>
                  <Table.Cell width="15%">{supply.cost}</Table.Cell>
                  <Table.Cell width="15%">1</Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Box>
      </Flex>
    </Section>
  );
};
