import { map } from 'common/collections';
import { useState } from 'react';
import {
  Button,
  Collapsible,
  Flex,
  LabeledList,
  Section,
  Table,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ShuttleManipulator = (props) => {
  const [tab, setTab] = useState(1);

  return (
    <Window
      title="Shuttle Manipulator"
      width={875}
      height={600}
      resizable
      theme="admin"
    >
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Status
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Templates
          </Tabs.Tab>
          <Tabs.Tab onClick={() => act('new_template')}>
            Upload New Template
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <ShuttleManipulatorStatus />}
        {tab === 2 && <ShuttleManipulatorTemplates />}
      </Window.Content>
    </Window>
  );
};

export const ShuttleManipulatorStatus = (props) => {
  const { act, data } = useBackend();
  const shuttles = data.shuttles || [];
  return (
    <Section>
      <Table>
        {shuttles.map((shuttle) => (
          <Table.Row key={shuttle.id}>
            <Table.Cell>
              <Button
                content="Fly"
                key={shuttle.id}
                disabled={!shuttle.can_fly}
                onClick={() =>
                  act('fly', {
                    id: shuttle.id,
                  })
                }
              />
              <Button
                content="JMP"
                key={shuttle.id}
                onClick={() =>
                  act('jump_to', {
                    type: 'mobile',
                    id: shuttle.id,
                  })
                }
              />
              <Button
                content="OWN"
                key={shuttle.id}
                onClick={() =>
                  act('owner', {
                    id: shuttle.id,
                  })
                }
              />
              <Button
                content="VV (P)"
                key={shuttle.id}
                onClick={() =>
                  act('vv_port', {
                    id: shuttle.id,
                  })
                }
              />
              <Button
                content="VV (S)"
                key={shuttle.id}
                onClick={() =>
                  act('vv_ship', {
                    id: shuttle.id,
                  })
                }
              />
              <Button
                content="BLIST"
                key={shuttle.id}
                onClick={() =>
                  act('blist', {
                    id: shuttle.id,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>{shuttle.name}</Table.Cell>
            <Table.Cell>{shuttle.type}</Table.Cell>
            <Table.Cell>{shuttle.position}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

export const ShuttleManipulatorTemplates = (props) => {
  const { act, data } = useBackend();
  const templateObject = data.templates || {};
  const [selectedTemplateId, setSelectedTemplateId] = useState(
    Object.keys(templateObject)[0],
  );
  const actualTemplates = templateObject[selectedTemplateId]?.templates || [];

  return (
    <Section>
      <Flex>
        <Flex.Item>
          <Tabs vertical>
            {map(templateObject, (template, templateId) => (
              <Tabs.Tab
                key={templateId}
                selected={selectedTemplateId === templateId}
                onClick={() => setSelectedTemplateId(templateId)}
              >
                {template.category}
              </Tabs.Tab>
            ))(templateObject)}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          {actualTemplates.map((actualTemplate) => {
            // Whoever made the structure being sent is an asshole
            return (
              <Collapsible
                title={actualTemplate.name}
                level={2}
                key={actualTemplate.file_name}
                buttons={
                  <>
                    <Button
                      content="Edit"
                      onClick={() =>
                        act('edit_template', {
                          file_name: actualTemplate.file_name,
                        })
                      }
                    />
                    <Button.Confirm
                      content="Load"
                      onClick={() =>
                        act('select_template', {
                          file_name: actualTemplate.file_name,
                        })
                      }
                    />
                  </>
                }
              >
                {
                  <LabeledList>
                    <LabeledList.Item label="Description">
                      {actualTemplate.description || 'No Description'}
                    </LabeledList.Item>
                    <LabeledList.Item label="Ship Tags">
                      {(actualTemplate.tags &&
                        actualTemplate.tags.join(', ')) ||
                        'No Tags Set'}
                    </LabeledList.Item>
                  </LabeledList>
                }
              </Collapsible>
            );
          })}
        </Flex.Item>
      </Flex>
    </Section>
  );
};
