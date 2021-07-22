import { map } from 'common/collections';
import { useBackend, useLocalState } from '../backend';
import { Button, Flex, LabeledList, Section, Table, Tabs } from '../components';
import { Window } from '../layouts';

export const ShuttleManipulator = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  return (
    <Window
      title="Shuttle Manipulator"
      width={800}
      height={600}
      resizable>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Status
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Templates
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 3}
            onClick={() => setTab(3)}>
            Modification
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <ShuttleManipulatorStatus />
        )}
        {tab === 2 && (
          <ShuttleManipulatorTemplates />
        )}
        {tab === 3 && (
          <ShuttleManipulatorModification />
        )}
      </Window.Content>
    </Window>
  );
};

export const ShuttleManipulatorStatus = (props, context) => {
  const { act, data } = useBackend(context);
  const shuttles = data.shuttles || [];
  return (
    <Section>
      <Table>
        {shuttles.map(shuttle => (
          <Table.Row key={shuttle.id}>
            <Table.Cell>
              <Button
                content="JMP"
                key={shuttle.id}
                onClick={() => act('jump_to', {
                  type: 'mobile',
                  id: shuttle.id,
                })} />
            </Table.Cell>
            <Table.Cell>
              <Button
                content="Fly"
                key={shuttle.id}
                disabled={!shuttle.can_fly}
                onClick={() => act('fly', {
                  id: shuttle.id,
                })} />
            </Table.Cell>
            <Table.Cell>
              {shuttle.name}
            </Table.Cell>
            <Table.Cell>
              {shuttle.id}
            </Table.Cell>
            <Table.Cell>
              {shuttle.status}
            </Table.Cell>
            <Table.Cell>
              {shuttle.mode}
              {!!shuttle.timer && (
                <>
                  ({shuttle.timeleft})
                  <Button
                    content="Fast Travel"
                    key={shuttle.id}
                    disabled={!shuttle.can_fast_travel}
                    onClick={() => act('fast_travel', {
                      id: shuttle.id,
                    })} />
                </>
              )}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

export const ShuttleManipulatorTemplates = (props, context) => {
  const { act, data } = useBackend(context);
  const templateObject = data.templates || {};
  const selected = data.selected || {};
  const [
    selectedTemplateId,
    setSelectedTemplateId,
  ] = useLocalState(context, 'templateId', Object.keys(templateObject)[0]);
  const actualTemplates = templateObject[selectedTemplateId]?.templates || [];
  return (
    <Section>
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {map((template, templateId) => (
              <Tabs.Tab
                key={templateId}
                selected={selectedTemplateId === templateId}
                onClick={() => setSelectedTemplateId(templateId)}>
                {template.category}
              </Tabs.Tab>
            ))(templateObject)}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          {actualTemplates.map(actualTemplate => {
            const isSelected = (
              actualTemplate.file_name === selected.file_name
            );
            // Whoever made the structure being sent is an asshole
            return (
              <Section
                title={actualTemplate.name}
                level={2}
                key={actualTemplate.file_name}
                buttons={(
                  <Button
                    content={isSelected ? 'Selected' : 'Select'}
                    selected={isSelected}
                    onClick={() => act('select_template', {
                      file_name: actualTemplate.file_name,
                    })} />
                )}>
                {(!!actualTemplate.description
                  || !!actualTemplate.admin_notes
                ) && (
                  <LabeledList>
                    {!!actualTemplate.description && (
                      <LabeledList.Item label="Description">
                        {actualTemplate.description}
                      </LabeledList.Item>
                    )}
                    {!!actualTemplate.admin_notes && (
                      <LabeledList.Item label="Admin Notes">
                        {actualTemplate.admin_notes}
                      </LabeledList.Item>
                    )}
                  </LabeledList>
                )}
              </Section>
            );
          })}
        </Flex.Item>
      </Flex>
    </Section>
  );
};

export const ShuttleManipulatorModification = (props, context) => {
  const { act, data } = useBackend(context);
  const selected = data.selected || {};
  return (
    <Section>
      {selected ? (
        <>
          <Section
            level={2}
            title={selected.name}>
            {(!!selected.description || !!selected.admin_notes) && (
              <LabeledList>
                {!!selected.description && (
                  <LabeledList.Item label="Description">
                    {selected.description}
                  </LabeledList.Item>
                )}
                {!!selected.admin_notes && (
                  <LabeledList.Item label="Admin Notes">
                    {selected.admin_notes}
                  </LabeledList.Item>
                )}
              </LabeledList>
            )}
          </Section>
          <Section
            level={2}
            title="Status">
            <Button
              content="Preview"
              onClick={() => act('preview', {
                file_name: selected.file_name,
              })} />
            <Button
              content="Load"
              color="bad"
              onClick={() => act('load', {
                file_name: selected.file_name,
              })} />
          </Section>
        </>
      ) : 'No shuttle selected'}
    </Section>
  );
};
