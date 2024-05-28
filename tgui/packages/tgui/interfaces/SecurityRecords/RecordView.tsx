import { useBackend, useLocalState } from 'tgui/backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
  Table,
} from 'tgui/components';

import { EditableText } from '../common/EditableText';
import { CRIMESTATUS2COLOR, CRIMESTATUS2DESC } from './constants';
import { getSecurityRecord } from './helpers';
import { SecurityRecordsData } from './types';

/** Views a selected record. */
export const SecurityRecordView = (props, context) => {
  const foundRecord = getSecurityRecord(props, context);
  if (!foundRecord) return <NoticeBox>Nothing selected.</NoticeBox>;

  const { data } = useBackend<SecurityRecordsData>(context);
  const { assigned_view } = data;

  const [open] = useLocalState<boolean>(context, 'printOpen', false);

  return (
    <Stack fill vertical>
      <Stack.Item grow>{<RecordInfo />}</Stack.Item>
    </Stack>
  );
};

const RecordInfo = (props, context) => {
  const foundRecord = getSecurityRecord(props, context);
  if (!foundRecord) return <NoticeBox>Nothing selected.</NoticeBox>;

  const { act, data } = useBackend<SecurityRecordsData>(context);
  const { available_statuses } = data;
  const [open, setOpen] = useLocalState<boolean>(context, 'printOpen', false);

  const { min_age, max_age } = data;

  const {
    age,
    record_ref,
    crimes,
    fingerprint,
    gender,
    name,
    security_note,
    rank,
    species,
    wanted_status,
  } = foundRecord;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section
          buttons={
            <Stack>
              <Stack.Item>
                <Button.Confirm
                  content="Delete"
                  icon="trash"
                  onClick={() =>
                    act('delete_record', { record_ref: record_ref })
                  }
                  tooltip="Delete record data."
                />
              </Stack.Item>
            </Stack>
          }
          fill
          title={
            <Table.Cell color={CRIMESTATUS2COLOR[wanted_status]}>
              {name}
            </Table.Cell>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Name">
              <EditableText field="name" target_ref={record_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="Job">
              <EditableText field="rank" target_ref={record_ref} text={rank} />
            </LabeledList.Item>
            <LabeledList.Item label="Age">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(event, value) =>
                  act('edit_field', {
                    record_ref: record_ref,
                    field: 'age',
                    value: value,
                  })
                }
                value={age}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Species">
              <EditableText
                field="species"
                target_ref={record_ref}
                text={species}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Gender">
              <EditableText
                field="gender"
                target_ref={record_ref}
                text={gender}
              />
            </LabeledList.Item>
            <LabeledList.Item color="good" label="Fingerprint">
              <EditableText
                color="good"
                field="fingerprint"
                target_ref={record_ref}
                text={fingerprint}
              />
            </LabeledList.Item>
            <LabeledList.Item
              buttons={available_statuses.map((button, index) => {
                const isSelected = button === wanted_status;
                return (
                  <Button
                    color={isSelected ? CRIMESTATUS2COLOR[button] : 'grey'}
                    icon={isSelected ? 'check' : ''}
                    key={index}
                    onClick={() =>
                      act('set_wanted_status', {
                        record_ref: record_ref,
                        wanted_status: button,
                      })
                    }
                    height={'1.75rem'}
                    width={!isSelected ? '3.0rem' : 3.0}
                    textAlign="center"
                    tooltip={CRIMESTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Wanted Status"
            >
              <Box color={CRIMESTATUS2COLOR[wanted_status]}>
                {wanted_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Note">
              <EditableText
                field="security_note"
                target_ref={record_ref}
                text={security_note}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
