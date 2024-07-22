import { sortBy } from 'common/collections';

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
  Stack,
  Section,
  Tabs,
  Table,
} from '../../components';
import { Window } from '../../layouts';
import { formatMoney } from '../../format';

import { searchForSupplies } from './helpers';
import { CargoData, SupplyPack, SupplyCategory } from './types';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const {} = data;

  const supply_packs = Object.values(data.supply_packs);

  const [activeSupplyName, setActiveSupplyName] = useSharedState(
    context,
    'supply',
    supply_packs[0]?.name
  );
  const [searchText, setSearchText] = useSharedState(
    context,
    'search_text',
    ''
  );

  const packs = () => {
    let fetched: SupplyPack[] | undefined;

    if (activeSupplyName === 'search_results') {
      fetched = searchForSupplies(supply_packs, searchText);
    } else {
      fetched = supply_packs.find(
        (supply) => supply.name === activeSupplyName
      )?.packs;
    }

    if (!fetched) return [];

    return fetched;
  };

  return (
    <Section title="Catalog" fill scrollable>
      <Flex>
        <CatalogTabs
          activeSupplyName={activeSupplyName}
          categories={supply_packs}
          searchText={searchText}
          setActiveSupplyName={setActiveSupplyName}
          setSearchText={setSearchText}
        />
        <Box width="70%">
          <CatalogList packs={packs()} />
        </Box>
      </Flex>
    </Section>
  );
};

type CatalogTabsProps = {
  activeSupplyName: string;
  categories: SupplyCategory[];
  searchText: string;
  setActiveSupplyName: (name: string) => void;
  setSearchText: (text: string) => void;
};

function CatalogTabs(props: CatalogTabsProps) {
  const {
    activeSupplyName,
    categories,
    searchText,
    setActiveSupplyName,
    setSearchText,
  } = props;

  return (
    <Tabs vertical>
      <Tabs.Tab
        key="search_results"
        selected={activeSupplyName === 'search_results'}
      >
        <Stack align="center">
          <Stack.Item>
            <Icon name="search" />
          </Stack.Item>
          <Stack.Item grow>
            <Input
              fluid
              placeholder="Search..."
              value={searchText}
              onInput={(e, value) => {
                if (value === searchText) {
                  return;
                }

                if (value.length) {
                  // Start showing results
                  setActiveSupplyName('search_results');
                } else if (activeSupplyName === 'search_results') {
                  // return to normal category
                  setActiveSupplyName(categories[0]?.name);
                }
                setSearchText(value);
              }}
            />
          </Stack.Item>
        </Stack>
      </Tabs.Tab>

      {categories.map((supply) => (
        <Tabs.Tab
          className="candystripe"
          color={supply.name === activeSupplyName ? 'green' : undefined}
          key={supply.name}
          selected={supply.name === activeSupplyName}
          onClick={() => {
            setActiveSupplyName(supply.name);
            setSearchText('');
          }}
        >
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <Table.Cell>{supply.name}</Table.Cell>
            <Table.Cell> {supply.packs.length}</Table.Cell>
          </div>
        </Tabs.Tab>
      ))}
    </Tabs>
  );
}

type CatalogListProps = {
  packs: SupplyCategory['packs'];
};

function CatalogList(props: CatalogListProps, context) {
  const { act, data } = useBackend<CargoData>(context);
  const {} = data;
  const { packs = [] } = props;

  return (
    <Table>
      <Table.Row header>
        <Table.Cell>Name</Table.Cell>
        <Table.Cell>Stock</Table.Cell>
        <Table.Cell>Cost</Table.Cell>
      </Table.Row>
      {packs.map((pack) => {
        return (
          <Table.Row key={pack.ref} className="candystripe">
            <Table.Cell width="70%">{pack.name}</Table.Cell>
            <Table.Cell width="15%">1</Table.Cell>
            <Table.Cell width="15%" collapsing textAlign="right">
              <Button
                fluid
                tooltip={pack.desc}
                tooltipPosition="left"
                onClick={() =>
                  act('add', {
                    ref: pack.ref,
                  })
                }
              >
                {formatMoney(pack.cost)}
                {' cr'}
              </Button>
            </Table.Cell>
          </Table.Row>
        );
      })}
    </Table>
  );
}
