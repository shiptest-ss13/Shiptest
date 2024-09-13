import { BooleanLike } from 'common/react';

export type MedicalRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
  library_name: string;
  physical_statuses: string[];
  mental_statuses: string[];
  records: MedicalRecord[];
  min_age: number;
  max_age: number;
};

export type MedicalRecord = {
  record_ref: string;
  rank: string;
  name: string;
  age: number;
  gender: string;
  species: string;
  blood_type: string;
  dna: string;
  disabilities: string;
  physical_status: string;
  mental_status: string;
  notes: MedicalNote[];
};

export type MedicalNote = {
  author: string;
  content: string;
  note_ref: string;
  time: string;
};
