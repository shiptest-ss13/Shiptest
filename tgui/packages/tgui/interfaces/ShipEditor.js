import { useBackend, useLocalState } from '../backend';
import {
  Dropdown,
  Input,
  LabeledList,
  NumberInput,
  Section,
  Table,
} from '../components';
import { Button } from '../components/Button';
import { Window } from '../layouts';

export const ShipEditor = (props, context) => {
  const { act, data } = useBackend(context);
  const outfits = [];

  for (let name in data.outfits) {
    outfits.push(name);
  }

  const [tagText, setTagText] = useLocalState(context, 'tagText', '');

  return (
    <Window title="Ship Editor" width={500} height={600}>
      <Window.Content>
        <Section title="Details">
          <LabeledList>
            <LabeledList.Item label="Name">
              <Input
                value={data.templateName}
                width={20}
                onChange={(e, value) =>
                  act('setTemplateName', { new_template_name: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Display Name">
              <Input
                value={data.templateShortName}
                placeholder={data.templateName}
                maxLength={20}
                onChange={(e, value) =>
                  act('setTemplateShortName', {
                    new_template_short_name: value,
                  })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Description">
              <Input
                value={data.templateDescription}
                width={20}
                height={10}
                placeholder={'No description'}
                onChange={(e, value) =>
                  act('setTemplateDescription', {
                    new_template_description: value,
                  })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Add Ship Tag">
              {
                <>
                  <Input
                    placeholder="Add Tag..."
                    autoFocus
                    value={tagText}
                    onInput={(_, value) => {
                      setTagText(value);
                    }}
                  />

                  <Button
                    content="Add"
                    value={tagText}
                    onClick={(e, value) => {
                      act('addTemplateTags', {
                        new_template_tags: tagText,
                      });
                    }}
                  />

                  <Button
                    content="Remove"
                    value={tagText}
                    onClick={(e, value) => {
                      act('removeTemplateTags', {
                        new_template_tags: tagText,
                      });
                    }}
                  />
                </>
              }
            </LabeledList.Item>

            <LabeledList.Item label="Ship Category">
              <Input
                value={data.templateCategory}
                onChange={(e, value) =>
                  act('setTemplateCategory', { new_template_category: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Limit">
              <NumberInput
                value={data.templateLimit}
                minValue={0}
                maxValue={100}
                stepPixelSize={30}
                onChange={(e, value) =>
                  act('setTemplateLimit', { new_template_limit: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Spawn Time Coeff.">
              <NumberInput
                value={data.templateSpawnCoeff}
                minValue={0}
                maxValue={100}
                stepPixelSize={30}
                onChange={(e, value) =>
                  act('setSpawnCoeff', { new_spawn_coeff: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Officer Time Coeff.">
              <NumberInput
                value={data.templateOfficerCoeff}
                minValue={0}
                maxValue={100}
                stepPixelSize={30}
                onChange={(e, value) =>
                  act('setOfficerCoeff', { new_officer_coeff: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Enabled">
              <Button
                content={data.templateEnabled ? 'Enabled' : 'Disabled'}
                icon={data.templateEnabled ? 'lock-open' : 'lock'}
                color={data.templateEnabled ? 'good' : 'bad'}
                onClick={() => act('toggleTemplateEnabled')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>

        <Section title="Job Slots">
          <Table>
            <Table.Row header>
              <Table.Cell>Officer</Table.Cell>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Outfit</Table.Cell>
              <Table.Cell>Slots</Table.Cell>
            </Table.Row>

            {data.templateJobs.map((job) => (
              <Table.Row key={job.name}>
                <Table.Cell>
                  <Button
                    icon={job.officer ? 'chess-king' : 'chess-pawn'}
                    color={job.officer && 'good'}
                    tooltip={job.officer ? 'Officer' : 'Crewmember'}
                    onClick={() =>
                      act('toggleJobOfficer', {
                        job_ref: job.ref,
                      })
                    }
                  />
                </Table.Cell>

                <Table.Cell>
                  <Input
                    value={job.name}
                    placeholder={'No name'}
                    onChange={(e, value) =>
                      act('setJobName', {
                        job_ref: job.ref,
                        job_name: value,
                      })
                    }
                  />
                </Table.Cell>

                <Table.Cell>
                  <Dropdown
                    selected={job.outfit}
                    options={outfits}
                    width={20}
                    onSelected={(value) =>
                      act('setJobOutfit', {
                        job_ref: job.ref,
                        job_outfit: value,
                      })
                    }
                  />
                </Table.Cell>

                <Table.Cell>
                  <NumberInput
                    value={job.slots}
                    minValue={0}
                    maxValue={100}
                    onChange={(e, value) =>
                      act('setJobSlots', {
                        job_ref: job.ref,
                        job_slots: value,
                      })
                    }
                  />
                </Table.Cell>
              </Table.Row>
            ))}

            <Table.Row>
              <Table.Cell>
                <Button
                  icon="plus"
                  color="good"
                  tooltip="Add new slot"
                  onClick={() => act('addJobSlot')}
                />
              </Table.Cell>
            </Table.Row>
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
