import { filter, sortBy } from 'common/collections';
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

import { CRIMESTATUS2COLOR } from './constants';
import { SecurityRecord, SecurityRecordsData } from './types';

/** Tabs on left, with search bar */
export const SecurityRecordTabs = (props, context) => {
  const { act, data } = useBackend<SecurityRecordsData>(context);
  const { higher_access, records = [], station_z } = data;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill scrollable>
          <Tabs vertical>
            {records.map((record, index) => (
              <CrewTab record={record} key={index} />
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item align="center">
        <Stack fill>
          <Stack.Item>
            <Button content="Create" icon="plus" tooltip="New Record!"></Button>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              content="Purge"
              disabled={!higher_access || !station_z}
              icon="trash"
              onClick={() => act('purge_records')}
              tooltip="Wipe criminal record data."
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
  >('securityRecord', undefined);

  const { act, data } = useBackend<SecurityRecordsData>(context);
  const { assigned_view } = data;
  const { record } = props;
  const { crew_ref, name, trim, wanted_status } = record;

  /** Chooses a record */
  const selectRecord = (record: SecurityRecord) => {
    if (selectedRecord?.crew_ref === crew_ref) {
      setSelectedRecord(undefined);
    } else {
      setSelectedRecord(record);
      act('view_record', { assigned_view: assigned_view, crew_ref: crew_ref });
    }
  };

  const isSelected = selectedRecord?.crew_ref === crew_ref;

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
