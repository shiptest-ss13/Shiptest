import { useBackend } from '../backend';
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

  return (
    <Window title="Ship Editor" width={400} height={600}>
      <Window.Content>
        <Section title="Details">
          <LabeledList>
            <LabeledList.Item label="Name">
              <Input
                value={data.templateName}
                onChange={(e, value) =>
                  act('setTemplateName', { new_template_name: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Display Name">
              <Input
                value={data.templateShortName}
                placeholder={data.templateName}
                onChange={(e, value) =>
                  act('setTemplateShortName', {
                    new_template_short_name: value,
                  })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Admin Panel Category">
              <Input
                value={data.templateCategory}
                onChange={(value) =>
                  act('setTemplateCategory', { new_template_category: value })
                }
              />
            </LabeledList.Item>

            <LabeledList.Item label="Limit">
              <NumberInput
                value={data.templateLimit}
                minValue={0}
                maxValue={100}
                stepPixelsSize={10}
                onChange={(e, value) =>
                  act('setTemplateLimit', { new_template_limit: value })
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

            {data.jobs.map((job) => (
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
                    options={data.outfits}
                    onSelect={(value) =>
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
