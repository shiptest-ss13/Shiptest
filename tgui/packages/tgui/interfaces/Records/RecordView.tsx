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
import { MedicalRecordData } from './types';

/** Views a selected record. */
export const MedicalRecordView = (props, context) => {
  const foundRecord = getMedicalRecord(props, context);
  if (!foundRecord) return <NoticeBox>No record selected.</NoticeBox>;

  const { act, data } = useBackend(context);

  const {
    age,
    blood_type,
    crew_ref,
    dna,
    gender,
    physical_status,
    mental_status,
    name,
    rank,
    species,
  } = foundRecord;

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          buttons={
            <Button.Confirm
              content="Delete"
              icon="trash"
              onClick={() => act('expunge_record', { crew_ref: crew_ref })}
              tooltip="Expunge record data."
            />
          }
          fill
          scrollable
          title={name}
        >
          <LabeledList>
            <LabeledList.Item label="Name">
              <EditableText field="name" target_ref={crew_ref} text={name} />
            </LabeledList.Item>
            <LabeledList.Item label="Job">
              <EditableText field="job" target_ref={crew_ref} text={rank} />
            </LabeledList.Item>
            <LabeledList.Item label="Age">
              <RestrictedInput
                onEnter={(event, value) =>
                  act('edit_field', {
                    field: 'age',
                    ref: crew_ref,
                    value: value,
                  })
                }
                value={age}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Species">
              <EditableText
                field="species"
                target_ref={crew_ref}
                text={species}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Gender">
              <EditableText
                field="gender"
                target_ref={crew_ref}
                text={gender}
              />
            </LabeledList.Item>
            <LabeledList.Item label="DNA">
              <EditableText
                color="good"
                field="dna"
                target_ref={crew_ref}
                text={dna}
              />
            </LabeledList.Item>
            <LabeledList.Item color="bad" label="Blood Type">
              <EditableText
                field="blood_type"
                target_ref={crew_ref}
                text={blood_type}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
