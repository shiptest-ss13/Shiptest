import { filter, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { useState } from 'react';
import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  Icon,
  Input,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui/components';

import { MedicalRecord, MedicalRecordData } from './types';

/** Displays all found records. */
export const MedicalRecordTabs = (props, context) => {
  const { act, data } = useBackend<MedicalRecordData>(context);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {data.records.map((record, index) => (
              <CrewTab key={index} record={record} />
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button
              disabled
              icon="plus"
              tooltip="Add new records by inserting a 1 by 1 meter photo into the terminal. You do not need this screen open."
            >
              Create
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
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
  const [selectedRecord, setSelectedRecord] = useLocalState(
    context,
    'medicalRecord',
    undefined
  );

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

  return (
    <Tabs.Tab
      className="candystripe"
      onClick={() => selectRecord(record)}
      selected={selectedRecord?.record_ref === record_ref}
    >
      {name}
    </Tabs.Tab>
  );
};
