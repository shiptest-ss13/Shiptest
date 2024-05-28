import { useBackend, useLocalState } from 'tgui/backend';

import { MedicalRecord, MedicalRecordData } from './types';

/** Splits a medical string on <br> into a string array */
export const getQuirkStrings = (string: string) => {
  return string?.split('<br>') || [];
};

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
