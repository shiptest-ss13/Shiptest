import { useBackend, useSharedState } from '../../backend';
import {
  Button,
  Flex,
  Icon,
  Input,
  Stack,
  Section,
  Tabs,
  Table,
} from '../../components';
import { formatMoney } from '../../format';

import { searchForSupplies } from './helpers';
import { CargoData, SupplyPack, SupplyCategory } from './types';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);

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
    <Section title="Catalog">
      <Flex>
        <Flex.Item ml={-1} mr={1.5}>
          <CatalogTabs
            activeSupplyName={activeSupplyName}
            categories={supply_packs}
            searchText={searchText}
            setActiveSupplyName={setActiveSupplyName}
            setSearchText={setSearchText}
          />
        </Flex.Item>
        <Flex.Item grow={1}>
          <CatalogList packs={packs()} />
        </Flex.Item>
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

export const CatalogTabs = (props: CatalogTabsProps) => {
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
          <Table.Row
            style={{ display: 'flex', justifyContent: 'space-between' }}
          >
            <Table.Cell>{supply.name}</Table.Cell>
            <Table.Cell> {supply.packs.length}</Table.Cell>
          </Table.Row>
        </Tabs.Tab>
      ))}
    </Tabs>
  );
};

type CatalogListProps = {
  packs: SupplyCategory['packs'];
};

export const CatalogList = (props: CatalogListProps, context) => {
  const { act, data } = useBackend<CargoData>(context);
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
            <Table.Cell>{pack.name}</Table.Cell>
            <Table.Cell>{pack.stock}</Table.Cell>
            <Table.Cell textAlign="right">
              <Button
                fluid
                tooltip={pack.desc}
                color={
                  pack.discountedcost || pack.faction_locked
                    ? 'green'
                    : 'default'
                }
                tooltipPosition="left"
                onClick={() =>
                  act('add', {
                    ref: pack.ref,
                  })
                }
              >
                {pack.discountedcost
                  ? ' (-' + pack.discountpercent + '%) ' + pack.discountedcost
                  : formatMoney(pack.cost)}
                {' cr'}
              </Button>
            </Table.Cell>
          </Table.Row>
        );
      })}
    </Table>
  );
};
