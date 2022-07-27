import { useBackend, useSharedState } from '../backend';
import {
  Box,
  Button,
  Dimmer,
  Icon,
  LabeledList,
  Stack,
  Section,
  Tabs,
} from '../components';
import { capitalize } from 'common/string';
import { Window } from '../layouts';

export const Limbgrower = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    reagents = [],
    total_reagents,
    max_reagents,
    categories = [],
    busy,
  } = data;
  const [tab, setTab] = useSharedState(
    context,
    'category',
    categories[0]?.name
  );
  const designList = categories.find(
    (category) => category.name === tab
  )?.designs;

  return (
    <Window
      title="Limb Grower"
      width={500}
      height={
        Math.max(460, 195 + categories.length * 23) + reagents.length * 25
      }
      resizable
    >
      {!!busy && (
        <Dimmer fontSize="32px">
          <Icon name="cog" spin={1} />
          {' Building...'}
        </Dimmer>
      )}
      <Window.Content scrollable>
        <Section title="Reagents">
          <Box mb={1}>
            {total_reagents} / {max_reagents} reagent capacity used.
          </Box>
          <LabeledList>
            {reagents.map((reagent) => (
              <LabeledList.Item
                key={reagent.reagent_name}
                label={reagent.reagent_name}
                buttons={
                  <Button.Confirm
                    textAlign="center"
                    width="120px"
                    content="Remove Reagent"
                    color="bad"
                    onClick={() =>
                      act('empty_reagent', {
                        reagent_type: reagent.reagent_type,
                      })
                    }
                  />
                }
              >
                {reagent.reagent_amount}u
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
        <Box>
          <Section title="Designs">
            <Stack>
              <Stack.Item mr={1} fill>
                <Section>
                  <Tabs vertical>
                    {categories.map((category) => (
                      <Tabs.Tab
                        key={category.name}
                        selected={tab === category.name}
                        onClick={() => setTab(category.name)}
                      >
                        {capitalize(category.name)}
                      </Tabs.Tab>
                    ))}
                  </Tabs>
                </Section>
              </Stack.Item>
              <Stack.Item grow fill>
                <LabeledList>
                  {designList.map((design) => (
                    <LabeledList.Item
                      key={design.name}
                      label={design.name}
                      className="candystripe"
                      buttons={
                        <Button
                          content="Make"
                          color="good"
                          onClick={() =>
                            act('make_limb', {
                              design_id: design.id,
                              active_tab: design.parent_category,
                            })
                          }
                        />
                      }
                    >
                      {design.needed_reagents.map((reagent) => (
                        <Box key={reagent.name}>
                          {reagent.name}: {reagent.amount}u
                        </Box>
                      ))}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              </Stack.Item>
            </Stack>
          </Section>
        </Box>
      </Window.Content>
    </Window>
  );
};
