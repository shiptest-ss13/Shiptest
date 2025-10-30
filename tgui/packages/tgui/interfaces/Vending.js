import { Box, Button, Section, Table } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const VendingRow = (props) => {
  const { act, data } = useBackend();
  const { product, productStock, custom } = props;
  const { miningvendor, all_items_free, user } = data;
  const free = all_items_free || product.price === 0;
  const affix = miningvendor ? ' mp' : ' cr';
  return (
    <Table.Row>
      <Table.Cell collapsing>
        {(product.img && (
          <img
            src={`data:image/jpeg;base64,${product.img}`}
            style={{
              'vertical-align': 'middle',
              'horizontal-align': 'middle',
            }}
          />
        )) || (
          <span
            className={classes(['vending32x32', product.path])}
            style={{
              'vertical-align': 'middle',
              'horizontal-align': 'middle',
            }}
          />
        )}
      </Table.Cell>
      <Table.Cell bold>{product.name}</Table.Cell>
      <Table.Cell collapsing textAlign="center">
        <Box
          color={
            (custom && 'good') ||
            (product.max_amount < 0 && 'good') ||
            (productStock <= 0 && 'bad') ||
            (productStock <= product.max_amount / 2 && 'average') ||
            'good'
          }
        >
          {(custom && product.amount) ||
            (!productStock && '0') ||
            (product.max_amount >= 0 && productStock) ||
            (product.max_amount < 0 && '∞')}{' '}
          in stock
        </Box>
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {(custom && (
          <Button
            fluid
            content={data.access ? 'FREE' : product.price + affix}
            onClick={() =>
              act('dispense', {
                item: product.name,
              })
            }
          />
        )) || (
          <Button
            fluid
            disabled={
              productStock === 0 ||
              (!free &&
                (!data.user ||
                  (!miningvendor && product.price > data.user.cash) ||
                  (miningvendor && product.price > data.user.points)))
            }
            content={free ? 'FREE' : product.price + affix}
            onClick={() =>
              act('vend', {
                ref: product.ref,
              })
            }
          />
        )}
      </Table.Cell>
    </Table.Row>
  );
};

export const Vending = (props) => {
  const { act, data } = useBackend();
  const {
    user,
    all_items_free,
    miningvendor,
    product_records = [],
    coin_records = [],
    hidden_records = [],
    stock,
  } = data;
  let inventory;
  let custom = false;
  if (data.vending_machine_input) {
    inventory = data.vending_machine_input;
    custom = true;
  } else {
    inventory = [...product_records, ...coin_records];
    if (data.extended_inventory) {
      inventory = [...inventory, ...hidden_records];
    }
  }
  // Just in case we still have undefined values in the list
  inventory = inventory.filter((item) => !!item);
  return (
    <Window title="Vending Machine" width={450} height={600}>
      <Window.Content scrollable>
        {!all_items_free && (
          <Section title="User">
            {(user && (
              <Box>
                Welcome, <b>{user.name}</b>, <b>{user.job || 'Unemployed'}</b>!
                <br />
                Your balance is{' '}
                <b>
                  {miningvendor ? user.points || 0 : user.cash || 0}{' '}
                  {miningvendor ? 'points' : 'credits'}
                </b>
                .
              </Box>
            )) || (
              <Box color="light-grey">
                No registered cash card!
                <br />
                Please contact your local bank!
              </Box>
            )}
          </Section>
        )}
        <Section title="Products">
          <Table>
            {inventory.map((product) => (
              <VendingRow
                key={product.name}
                custom={custom}
                product={product}
                productStock={stock[product.name]}
              />
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
