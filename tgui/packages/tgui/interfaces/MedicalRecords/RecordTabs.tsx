import { useBackend, useLocalState } from 'tgui/backend';
import { Box, Button, Section, Stack, Tabs } from 'tgui/components';

import { MedicalRecord, MedicalRecordsData } from './types';

/** Displays all found records. */
export const MedicalRecordTabs = (props, context) => {
  const { act, data } = useBackend<MedicalRecordsData>(context);
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

/** Individual crew tab */
const CrewTab = (props: { record: MedicalRecord }, context) => {
  const [selectedRecord, setSelectedRecord] = useLocalState<
    MedicalRecord | undefined
  >(context, 'medicalRecord', undefined);

  const { act, data } = useBackend(context);
  const { assigned_view } = data;
  const { record } = props;
  const { record_ref, name } = record;

  /** Sets the record to preview */
  const selectRecord = (record: MedicalRecord) => {
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
      <Box bold={isSelected}>{name}</Box>
    </Tabs.Tab>
  );
};
