import { useBackend, useLocalState } from 'tgui/backend';
import { Box, Button, Section, Stack, Tabs } from 'tgui/components';

import { CRIMESTATUS2COLOR } from './constants';
import { SecurityRecord, SecurityRecordsData } from './types';

export const SecurityRecordTabs = (props, context) => {
  const { act, data } = useBackend<SecurityRecordsData>(context);
  const { records = [] } = data;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {records.map((record, index) => (
              <CrewTab key={index} record={record} />
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button
              content="Create"
              onClick={() => act('new_record')}
              icon="plus"
              tooltip="New Record."
            />
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled
              content="Purge"
              icon="trash"
              onClick={() => act('purge_records')}
              tooltip="Wipe all record data."
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

/** Individual record */
const CrewTab = (props: { record: SecurityRecord }, context) => {
  const [selectedRecord, setSelectedRecord] = useLocalState<
    SecurityRecord | undefined
  >(context, 'securityRecord', undefined);

  const { act, data } = useBackend<SecurityRecordsData>(context);
  const { assigned_view } = data;
  const { record } = props;
  const { record_ref, name, wanted_status } = record;

  /** Chooses a record */
  const selectRecord = (record: SecurityRecord) => {
    if (selectedRecord?.record_ref === record_ref) {
      setSelectedRecord(undefined);
    } else {
      setSelectedRecord(record);
      act('view_record', {
        assigned_view: assigned_view,
        record_ref: record_ref,
      });
    }
  };

  const isSelected = selectedRecord?.record_ref === record_ref;

  return (
    <Tabs.Tab
      className="candystripe"
      onClick={() => selectRecord(record)}
      selected={isSelected}
    >
      <Box bold={isSelected} color={CRIMESTATUS2COLOR[wanted_status]}>
        {name}
      </Box>
    </Tabs.Tab>
  );
};
