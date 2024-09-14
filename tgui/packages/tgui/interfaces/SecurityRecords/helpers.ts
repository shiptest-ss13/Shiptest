import { useBackend, useLocalState } from 'tgui/backend';

import { SecurityRecord, SecurityRecordsData } from './types';

/** We need an active reference and this a pain to rewrite */
export const getSecurityRecord = (props, context) => {
  const [selectedRecord, setRecord] = useLocalState<SecurityRecord | undefined>(
    context,
    'securityRecord',
    undefined
  );
  if (!selectedRecord) return;
  const { data } = useBackend<SecurityRecordsData>(context);
  const { records = [] } = data;
  const foundRecord = records.find(
    (record) => record.record_ref === selectedRecord.record_ref
  );
  if (!foundRecord) return;

  return foundRecord;
};
