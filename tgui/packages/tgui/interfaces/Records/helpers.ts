import { useBackend, useLocalState } from 'tgui/backend';

import { MedicalRecord, MedicalRecordData } from './types';

/** We need an active reference and this a pain to rewrite */
export const getMedicalRecord = (props, context) => {
  const [selectedRecord, SetRecord] = useLocalState(context, 'medicalRecord', '');
  const { data } = useBackend(context);
  const { records = [] } = data;
  const foundRecord = records.find(
    (record) => record.crew_ref === selectedRecord.crew_ref,
  );
  if (!foundRecord) return;

  return foundRecord;
};
