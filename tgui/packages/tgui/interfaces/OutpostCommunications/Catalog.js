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
  Collapsible,
  Tooltip,
} from '../../components';
import { formatMoney } from '../../format';

export const CargoCatalog = (props, context) => {
  const { act, data } = useBackend(context);

  const { self_paid, app_cost, blockade } = data;

  const categories = Object.values(data.categories);
  const all_packs = data.all_packs;

  const [activeCategoryName, setActiveCategoryName] = useSharedState(
    context,
    'category',
    categories[0]?.name
  );

  const [searchText, setSearchText] = useSharedState(
    context,
    'search_text',
    ''
  );

  const [cart, setCart] = useSharedState(context, 'cart', {});

  const addPack = (pack_ref, count = 1) => {
    setPack(pack_ref, (cart[pack_ref] ? cart[pack_ref] : 0) + count);
  };

  const setPack = (pack_ref, count) => {
    let tmpcart = { ...cart };
    if (count > 0) {
      tmpcart[pack_ref] = count;
    } else {
      delete tmpcart[pack_ref];
    }
    setCart(tmpcart);
  };

  const itemCount = Object.values(cart).reduce(
    (itemCount, current_count) => itemCount + current_count,
    0
  );

  const cartTotal = (() => {
    let total = 0;
    let item;
    for (const item_ref in cart) {
      item = all_packs[item_ref];
      total +=
        (item.discountedcost ? item.discountedcost : item.cost) *
        cart[item_ref];
    }
    return total;
  })();

  const activeCategory =
    activeCategoryName === 'search_results'
      ? { packs: searchForPacks(all_packs, searchText) }
      : categories.find((category) => category.name === activeCategoryName);

  return (
    <>
      <Section
        title="Cart"
        buttons={
          <>
            <Box inline my={1} mx={1}>
              {itemCount === 0 && 'Cart is empty'}
              {itemCount === 1 && '1 item'}
              {itemCount >= 2 && itemCount + ' items'}{' '}
              {cartTotal > 0 && `(${formatMoney(cartTotal)} cr)`}
            </Box>
            <Button
              icon="trash"
              color="transparent"
              content="Clear"
              onClick={() => setCart({})}
            />
            {blockade ? (
              <Button
                icon="triangle-exclamation"
                color="yellow"
                content="Purchase Unavailable"
              />
            ) : (
              <Button
                color="green"
                icon="shopping-cart"
                disabled={!itemCount}
                content="Purchase"
                onClick={() => {
                  act('purchase', {
                    cart: cart,
                    total: cartTotal,
                  });
                  setCart({});
                }}
              />
            )}
          </>
        }
      >
        {itemCount !== 0 ? (
          <Collapsible title="Cart Contents">
            <Table>
              {Object.entries(cart).map(([pack_ref, count]) => {
                const pack = all_packs[pack_ref];
                const actualcost = pack.discountedcost
                  ? pack.discountedcost
                  : pack.cost;
                return (
                  <Table.Row key={pack_ref} className="candystripe">
                    <Table.Cell>
                      <Button
                        icon="times"
                        color="transparent"
                        onClick={() => setPack(pack_ref, 0)}
                      />
                      <Input
                        width="40px"
                        value={count}
                        textAlign="right"
                        onChange={(e, value) => {
                          if (!isNaN(value) && value !== '') {
                            setPack(pack_ref, Number(value));
                          }
                        }}
                      />
                    </Table.Cell>
                    <Table.Cell textAlign="right">
                      <Tooltip
                        content={formatMoney(actualcost) + ' cr per unit.'}
                        position="right"
                      >
                        <Box>{formatMoney(actualcost * count) + ' cr'}</Box>
                      </Tooltip>
                    </Table.Cell>
                    <Table.Cell width="3%" />
                    <Table.Cell
                      collapsing
                      color="label"
                      textAlign="left"
                      width="70%"
                    >
                      <Tooltip content={pack.desc} position="bottom">
                        <Box> {pack.name} </Box>
                      </Tooltip>
                    </Table.Cell>
                  </Table.Row>
                );
              })}
            </Table>
          </Collapsible>
        ) : (
          <Box mb={1}>
            <Button
              icon="times"
              fluid
              ellipsis
              disabled={1}
              content="Cart is empty"
            />
          </Box>
        )}
      </Section>
      <Section title="Catalog">
        <Flex>
          <Flex.Item ml={-1} mr={1.5}>
            <Tabs vertical>
              <Tabs.Tab
                key="search_results"
                selected={activeCategoryName === 'search_results'}
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
                          setActiveCategoryName('search_results');
                        } else if (activeCategoryName === 'search_results') {
                          // return to normal category
                          setActiveCategoryName(categories[0]?.name);
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
              {categories.map((category) => (
                <Tabs.Tab
                  key={category.name}
                  selected={category.name === activeCategoryName}
                  onClick={() => {
                    setActiveCategoryName(category.name);
                    setSearchText('');
                  }}
                >
                  {category.name} ({category.packs.length})
                </Tabs.Tab>
              ))}
            </Tabs>
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            <Table>
              {activeCategory?.packs
                .map((pack_ref) => all_packs[pack_ref])
                .map((pack) => {
                  const tags = [];
                  // if (pack.no_bundle) {
                  //   tags.push('No Grouping');
                  // }
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
                          color={
                            pack.discountedcost || pack.faction_locked
                              ? 'green'
                              : 'default'
                          }
                          tooltipPosition="left"
                          onClick={() => addPack(pack.ref)}
                        >
                          {pack.discountedcost
                            ? ' (' +
                              (pack.discountpercent > 0
                                ? '-' + pack.discountpercent
                                : '+' + -pack.discountpercent) +
                              '%) ' +
                              formatMoney(pack.discountedcost)
                            : formatMoney(
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
    </>
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
const searchForPacks = (all_packs, search) => {
  search = search.toLowerCase();

  return flow([
    filter(
      (pack) =>
        pack.name?.toLowerCase().includes(search.toLowerCase()) ||
        pack.desc?.toLowerCase().includes(search.toLowerCase())
    ),
    sortBy((pack) => pack.name),
    (packs) => packs.slice(0, 25),
  ])(Object.values(all_packs)).map((pack) => pack.ref);
};
