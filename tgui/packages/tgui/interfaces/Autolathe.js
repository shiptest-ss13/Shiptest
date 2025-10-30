import {
  Box,
  Button,
  Collapsible,
  Dimmer,
  Flex,
  Icon,
  Input,
  LabeledList,
  NumberInput,
  ProgressBar,
  Section,
  Table,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

export const Autolathe = (props) => {
  const { act, data } = useBackend();
  // Extract `health` and `color` variables from the `data` object.
  const {
    materialtotal,
    materialsmax,
    materials = [],
    categories = [],
    designs = [],
    hasDisk,
    active,
  } = data;
  const [current_category, setCategory] = useLocalState(
    'current_category',
    'None',
  );
  const filteredmaterials = materials.filter(
    (material) => material.mineral_amount > 0,
  );
  return (
    <Window title="Autolathe" theme="ntos_terminal" width={600} height={700}>
      <Window.Content scrollable>
        <Section
          title="Total Materials"
          buttons={
            <Button
              icon="eject"
              content="Eject design disk"
              disabled={!hasDisk}
              onClick={() => {
                act('diskEject');
              }}
            />
          }
        >
          <LabeledList>
            <LabeledList.Item label="Total Materials">
              <ProgressBar
                value={materialtotal}
                minValue={0}
                maxValue={materialsmax}
                ranges={{
                  good: [materialsmax * 0.85, materialsmax],
                  average: [materialsmax * 0.25, materialsmax * 0.85],
                  bad: [0, materialsmax * 0.25],
                }}
              >
                {materialtotal + '/' + materialsmax + ' cm³'}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item>
              {filteredmaterials.length > 0 && (
                <Collapsible title="Materials">
                  <LabeledList>
                    {filteredmaterials.map((material) => (
                      <MaterialRow
                        key={material.id}
                        material={material}
                        materialsmax={materialsmax}
                        onRelease={(amount) =>
                          act('materialEject', {
                            materialName: material.name,
                            amount: amount,
                          })
                        }
                      />
                    ))}
                  </LabeledList>
                </Collapsible>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Search">
          <Input
            fluid
            placeholder="Search Recipes..."
            selfClear
            onChange={(e, value) => {
              if (value.length) {
                act('search', {
                  to_search: value,
                });
                setCategory('results for "' + value + '"');
              }
            }}
          />
        </Section>
        <Section title="Categories">
          <Box>
            {categories.map((category) => (
              // eslint-disable-next-line react/jsx-key
              <Button
                selected={current_category === category}
                content={category}
                onClick={() => {
                  act('category', {
                    selectedCategory: category,
                  });
                  setCategory(category);
                }}
              />
            ))}
          </Box>
        </Section>
        {current_category.toString() !== 'None' && (
          <Section
            title={'Displaying ' + current_category.toString()}
            buttons={
              <Button
                icon="times"
                content="Close Category"
                onClick={() => {
                  act('menu');
                  setCategory('None');
                }}
              />
            }
          >
            {active === 1 && (
              <Dimmer fontSize="32px">
                <Icon name="cog" spin />
                {'Building items...'}
              </Dimmer>
            )}
            <Flex direction="row" wrap="nowrap">
              <Table>
                {(designs.length &&
                  designs.map((design) => (
                    <Table.Row key={design.id}>
                      <Flex.Item>
                        <Button
                          content={design.name}
                          disabled={design.buildable}
                          onClick={() =>
                            act('make', {
                              id: design.id,
                              multiplier: '1',
                            })
                          }
                        />
                      </Flex.Item>
                      {design.sheet ? (
                        <Table.Cell>
                          <Flex.Item grow={1}>
                            <Button
                              icon="hammer"
                              content="10"
                              disabled={!design.mult10}
                              onClick={() =>
                                act('make', {
                                  id: design.id,
                                  multiplier: '10',
                                })
                              }
                            />
                            <Button
                              icon="hammer"
                              content="25"
                              disabled={!design.mult25}
                              onClick={() =>
                                act('make', {
                                  id: design.id,
                                  multiplier: '25',
                                })
                              }
                            />
                          </Flex.Item>
                        </Table.Cell>
                      ) : (
                        <Table.Cell>
                          <Flex.Item grow={3}>
                            <Button
                              icon="hammer"
                              content="5"
                              disabled={!design.mult5}
                              onClick={() =>
                                act('make', {
                                  id: design.id,
                                  multiplier: '5',
                                })
                              }
                            />
                            <Button
                              icon="hammer"
                              content="10"
                              disabled={!design.mult10}
                              onClick={() =>
                                act('make', {
                                  id: design.id,
                                  multiplier: '10',
                                })
                              }
                            />
                          </Flex.Item>
                        </Table.Cell>
                      )}
                      <Table.Cell>
                        <Button.Input
                          content={'[Max:' + design.maxmult + ']'}
                          maxValue={design.maxmult}
                          disabled={design.buildable}
                          backgroundColor={
                            design.buildable ? '#00000000' : 'default'
                          }
                          onCommit={(e, value) =>
                            act('make', {
                              id: design.id,
                              multiplier: value,
                            })
                          }
                        />
                      </Table.Cell>
                      {design.cost}
                    </Table.Row>
                  ))) || (
                  <Table.Row>
                    <Table.Cell>{'No designs found.'}</Table.Cell>
                  </Table.Row>
                )}
              </Table>
            </Flex>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const MaterialRow = (props) => {
  const { material, materialsmax, onRelease } = props;

  const [amount, setAmount] = useLocalState('amount' + material.name, 1);

  const amountAvailable = Math.floor(material.amount);
  return (
    <LabeledList.Item key={material.id}>
      <Table width="100%">
        <Table.Row>
          <Table.Cell>{capitalize(material.name)}</Table.Cell>
          <Table.Cell textAlign="right">
            <Box mr={2} color="label" inline>
              {material.sheets_amount} sheets
            </Box>
          </Table.Cell>
          <Table.Cell collapsing textAlign="right">
            <Button
              disabled={material.sheets_amount < 1}
              content="x1"
              onClick={() => onRelease(1)}
            />
            <Button
              disabled={material.sheets_amount < 5}
              content="x5"
              onClick={() => onRelease(5)}
            />
            <Button
              disabled={material.sheets_amount < 10}
              content="x10"
              onClick={() => onRelease(10)}
            />
            <Button
              disabled={material.sheets_amount < 25}
              content="x25"
              onClick={() => onRelease(25)}
            />
          </Table.Cell>
          <Table.Cell collapsing textAlign="right">
            <NumberInput
              width="32px"
              step={1}
              stepPixelSize={5}
              minValue={1}
              maxValue={material.sheets_amount}
              value={amount}
              onChange={(value) => setAmount(value)}
            />
            <Button
              disabled={material.sheets_amount < 1}
              content="Release"
              onClick={() => onRelease(amount)}
            />
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell colspan="4">
            <ProgressBar
              style={{
                transform: 'scaleX(-1) scaleY(1)',
              }}
              value={materialsmax - material.mineral_amount}
              maxValue={materialsmax}
              color="black"
              backgroundColor={material.matcolour}
            >
              <div style={{ transform: 'scaleX(-1)' }}>
                {material.mineral_amount + ' cm³'}
              </div>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>
      </Table>
    </LabeledList.Item>
  );
};
