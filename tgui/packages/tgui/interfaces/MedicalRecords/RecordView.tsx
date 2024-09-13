import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  RestrictedInput,
  Section,
  Stack,
} from 'tgui/components';

import { useBackend } from '../../backend';
import { EditableText } from '../common/EditableText';
import {
  MENTALSTATUS2COLOR,
  MENTALSTATUS2DESC,
  MENTALSTATUS2ICON,
  PHYSICALSTATUS2COLOR,
  PHYSICALSTATUS2DESC,
  PHYSICALSTATUS2ICON,
} from './constants';
import { getMedicalRecord } from './helpers';
import { NoteKeeper } from './NoteKeeper';
import { MedicalRecordsData } from './types';

/** Views a selected record. */
export const MedicalRecordView = (props, context) => {
  const foundRecord = getMedicalRecord(props, context);
  if (!foundRecord) return <NoticeBox>No record selected.</NoticeBox>;

  const { act, data } = useBackend<MedicalRecordsData>(context);
  const { physical_statuses, mental_statuses } = data;

  const { min_age, max_age } = data;

  const {
    record_ref,
    rank,
    name,
    age,
    species,
    gender,
    physical_status,
    mental_status,
    blood_type,
    dna,
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
          title={name}
        >
          <LabeledList>
            <LabeledList.Item label="Name">
              <EditableText field="name" target_ref={record_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="Rank">
              <EditableText field="rank" target_ref={record_ref} text={rank} />
            </LabeledList.Item>
            <LabeledList.Item label="Age">
              <RestrictedInput
                minValue={min_age}
                maxValue={max_age}
                onEnter={(event, value) =>
                  act('edit_field', {
                    field: 'age',
                    ref: record_ref,
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
            <LabeledList.Item label="DNA">
              <EditableText
                color="good"
                field="dna"
                target_ref={record_ref}
                text={dna}
              />
            </LabeledList.Item>
            <LabeledList.Item color="bad" label="Blood Type">
              <EditableText
                field="blood_type"
                target_ref={record_ref}
                text={blood_type}
              />
            </LabeledList.Item>
            <LabeledList.Item
              buttons={physical_statuses.map((button, index) => {
                const isSelected = button === physical_status;
                return (
                  <Button
                    color={isSelected ? PHYSICALSTATUS2COLOR[button] : 'grey'}
                    icon={PHYSICALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_physical_status', {
                        record_ref: record_ref,
                        physical_status: button,
                      })
                    }
                    height={'1.75rem'}
                    width={!isSelected ? '3.0rem' : 3.0}
                    textAlign="center"
                    tooltip={PHYSICALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Physical Status"
            >
              <Box color={PHYSICALSTATUS2COLOR[physical_status]}>
                {physical_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item
              buttons={mental_statuses.map((button, index) => {
                const isSelected = button === mental_status;
                return (
                  <Button
                    color={isSelected ? MENTALSTATUS2COLOR[button] : 'grey'}
                    icon={MENTALSTATUS2ICON[button]}
                    key={index}
                    onClick={() =>
                      act('set_mental_status', {
                        record_ref: record_ref,
                        mental_status: button,
                      })
                    }
                    height={'1.75rem'}
                    width={!isSelected ? '3.0rem' : 3.0}
                    textAlign="center"
                    tooltip={MENTALSTATUS2DESC[button] || ''}
                    tooltipPosition="bottom-start"
                  >
                    {button[0]}
                  </Button>
                );
              })}
              label="Mental Status"
            >
              <Box color={MENTALSTATUS2COLOR[mental_status]}>
                {mental_status}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <NoteKeeper />
      </Stack.Item>
    </Stack>
  );
};
