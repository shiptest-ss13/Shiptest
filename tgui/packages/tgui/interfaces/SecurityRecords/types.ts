import { BooleanLike } from 'common/react';

export type SecurityRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
  library_name: string;
  available_statuses: string[];
  current_user: string;
  records: SecurityRecord[];
  min_age: number;
  max_age: number;
};

export type SecurityRecord = {
  record_ref: string;
  rank: string;
  name: string;
  age: number;
  species: string;
  gender: string;
  crimes: Crime[];
  fingerprint: string;
  wanted_status: string;
  security_note: string;
};

export type Crime = {
  author: string;
  crime_ref: string;
  details: string;
  fine: number;
  name: string;
  paid: number;
  time: number;
};

export enum SECURETAB {
  Crimes,
  Citations,
  Add,
}
