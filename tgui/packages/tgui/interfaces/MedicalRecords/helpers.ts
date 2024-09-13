import { useBackend, useLocalState } from 'tgui/backend';

import { MedicalRecord } from './types';

/** We need an active reference and this a pain to rewrite */
export const getMedicalRecord = (props, context) => {
  const [selectedRecord, SetRecord] = useLocalState<MedicalRecord>(
    context,
    'medicalRecord',
    ''
  );
  if (!selectedRecord) return;
  const { data } = useBackend<MedicalRecord>(context);
  const { records = [] } = data;
  const foundRecord = records.find(
    (record) => record.record_ref === selectedRecord.record_ref
  );
  if (!foundRecord) return;

  return foundRecord;
};

/** Splits a medical string on <br> into a string array */
export const getQuirkStrings = (string: string) => {
  return string?.split('<br>') || [];
};
