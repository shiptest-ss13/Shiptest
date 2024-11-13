import { flow } from 'common/fp';
import { filter, sortBy } from 'common/collections';
import { useBackend, useSharedState } from '../../backend';
import {
  Box,
  Button,
  Flex,
  Icon,
  Input,
  Section,
  Stack,
  Table,
  Tabs,
} from '../../components';
import { formatMoney } from '../../format';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend(context);

  const { self_paid, app_cost } = data;

  const supplies = Object.values(data.supplies);

  const [activeSupplyName, setActiveSupplyName] = useSharedState(
    context,
    'supply',
    supplies[0]?.name
  );

  const [searchText, setSearchText] = useSharedState(
    context,
    'search_text',
    ''
  );

  const activeSupply =
    activeSupplyName === 'search_results'
      ? { packs: searchForSupplies(supplies, searchText) }
      : supplies.find((supply) => supply.name === activeSupplyName);

  return (
    <Section title="Catalog">
      <Flex>
        <Flex.Item ml={-1} mr={1}>
          <Tabs vertical>
            <Tabs.Tab
              key="search_results"
              selected={activeSupplyName === 'search_results'}
            >
              <Stack align="baseline">
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
                        setActiveSupplyName(supplies[0]?.name);
                      }
                      setSearchText(value);
                    }}
                    onChange={(e, value) => {
                      // Allow edge cases like the X button to work
                      const onInput = e.target?.props?.onInput;
                      if (onInput) {
                        onInput(e, value);
                      }
                    }}
                  />
                </Stack.Item>
              </Stack>
            </Tabs.Tab>
            {supplies.map((supply) => (
              <Tabs.Tab
                key={supply.name}
                selected={supply.name === activeSupplyName}
                onClick={() => {
                  setActiveSupplyName(supply.name);
                  setSearchText('');
                }}
              >
                {supply.name} ({supply.packs.length})
              </Tabs.Tab>
            ))}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          <Table>
            {activeSupply?.packs.map((pack) => {
              const tags = [];
              if (pack.small_item) {
                tags.push('Small');
              }
              if (pack.access) {
                tags.push('Restricted');
              }
              return (
                <Table.Row key={pack.name} className="candystripe">
                  <Table.Cell>{pack.name}</Table.Cell>
                  <Table.Cell collapsing color="label" textAlign="right">
                    {tags.join(', ')}
                  </Table.Cell>
                  <Table.Cell collapsing textAlign="right">
                    <Button
                      fluid
                      tooltip={pack.desc}
                      color={pack.discountedcost || pack.faction_locked ? "green" : "default"}
                      tooltipPosition="left"
                      onClick={() =>
                        act('add', {
                          ref: pack.ref,
                        })
                      }
                    >
                      {pack.discountedcost ?
                      ' (-' + pack.discountpercent +'%) ' + pack.discountedcost:
                      formatMoney(
                        (self_paid && !pack.goody) || app_cost
                          ? Math.round(pack.cost * 1.1)
                          : pack.cost
                      )}
                      {' cr'}
                    </Button>
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

/**
 * Take entire supplies tree
 * and return a flat supply pack list that matches search,
 * sorted by name and only the first page.
 * @param {any[]} supplies Supplies list.
 * @param {string} search The search term
 * @returns {any[]} The flat list of supply packs.
 */
const searchForSupplies = (supplies, search) => {
  search = search.toLowerCase();

  return flow([
    (categories) => categories.flatMap((category) => category.packs),
    filter(
      (pack) =>
        pack.name?.toLowerCase().includes(search.toLowerCase()) ||
        pack.desc?.toLowerCase().includes(search.toLowerCase())
    ),
    sortBy((pack) => pack.name),
    (packs) => packs.slice(0, 25),
  ])(supplies);
};

const CargoCartButtons = (props, context) => {
  const { act, data } = useBackend(context);
  const { requestonly, can_send, can_approve_requests } = data;
  const cart = data.cart || [];
  const total = cart.reduce((total, entry) => total + entry.cost, 0);
  if (requestonly || !can_send || !can_approve_requests) {
    return null;
  }
  return (
    <>
      <Box inline mx={1}>
        {cart.length === 0 && 'Cart is empty'}
        {cart.length === 1 && '1 item'}
        {cart.length >= 2 && cart.length + ' items'}{' '}
        {total > 0 && `(${formatMoney(total)} cr)`}
      </Box>
      <Button
        icon="times"
        color="transparent"
        content="Clear"
        onClick={() => act('clear')}
      />
    </>
  );
};
