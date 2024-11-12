import { createSearch } from '../../../common/string';

import { HEALTH } from './constants';
import { AntagGroup, Antagonist, Observable } from './types';

const PATTERN_NUMBER = / \(([0-9]+)\)$/;

/** Return a map of strings with each antag in its antag_category */
export const getAntagCategories = (antagonists: Antagonist[]): AntagGroup[] => {
  const categories = new Map<string, Antagonist[]>();

  for (const player of antagonists) {
    const { antag_group } = player;

    if (!categories.has(antag_group)) {
      categories.set(antag_group, []);
    }
    categories.get(antag_group)!.push(player);
  }

  const sorted = Array.from(categories.entries()).sort((a, b) => {
    const lowerA = a[0].toLowerCase();
    const lowerB = b[0].toLowerCase();

    if (lowerA < lowerB) return -1;
    if (lowerA > lowerB) return 1;
    return 0;
  });

  return sorted;
};

/** Returns a disguised name in case the person is wearing someone else's ID */
export const getDisplayName = (
  full_name: string,
  nickname?: string
): string => {
  if (!nickname) {
    return full_name;
  }

  return nickname;
};

/** Displays color for buttons based on the health or orbiter count. */
export const getDisplayColor = (
  item: Observable,
  override?: string
): string => {
  const { job, health, orbiters } = item;

  // Things like blob camera, etc
  if (typeof health !== 'number') {
    return override ? 'good' : 'grey';
  }

  // Players that are AFK
  if ('client' in item && !item.client) {
    return 'grey';
  }

  return getHealthColor(health);
};

/** Returns the display color for certain health percentages */
const getHealthColor = (health: number): string => {
  switch (true) {
    case health > HEALTH.Good:
      return 'good';
    case health > HEALTH.Average:
      return 'average';
    default:
      return 'bad';
  }
};

/** Checks if a full name or job title matches the search. */
export const isJobOrNameMatch = (
  observable: Observable,
  searchQuery: string
): boolean => {
  if (!searchQuery) return true;

  const { name, job } = observable;

  return (
    name?.toLowerCase().includes(searchQuery?.toLowerCase()) ||
    job?.toLowerCase().includes(searchQuery?.toLowerCase()) ||
    false
  );
};

export const searchFor = (searchText) =>
  createSearch(searchText, (thing: Observable) => thing.full_name);

export const compareString = (a, b) => (a < b ? -1 : a > b);

export const compareNumberedText = (a, b) => {
  const aName = a.name;
  const bName = b.name;

  // Check if aName and bName are the same except for a number at the end
  // e.g. Medibot (2) and Medibot (3)
  const aNumberMatch = aName.match(PATTERN_NUMBER);
  const bNumberMatch = bName.match(PATTERN_NUMBER);

  if (
    aNumberMatch &&
    bNumberMatch &&
    aName.replace(PATTERN_NUMBER, '') === bName.replace(PATTERN_NUMBER, '')
  ) {
    const aNumber = parseInt(aNumberMatch[1], 10);
    const bNumber = parseInt(bNumberMatch[1], 10);

    return aNumber - bNumber;
  }

  return compareString(aName, bName);
};
