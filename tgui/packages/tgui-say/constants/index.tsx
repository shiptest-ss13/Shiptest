/** Radio channels */
export const CHANNELS = ['Say', 'Radio', 'Me', 'OOC'] as const;

/** Window sizes in pixels */
export enum WINDOW_SIZES {
  small = 30,
  medium = 50,
  large = 70,
  width = 231,
}

/** Line lengths for autoexpand */
export enum LINE_LENGTHS {
  small = 20,
  medium = 35,
}

/**
 * Radio prefixes.
 * Contains the properties:
 * id - string. css class identifier.
 * label - string. button label.
 */
export const RADIO_PREFIXES = {
  ':a ': {
    id: 'hive',
    label: 'Hive',
  },
  ':b ': {
    id: 'binary',
    label: '0101',
  },
  ':c ': {
    id: 'command',
    label: 'Cmd',
  },
  ':e ': {
    id: 'centcomm',
    label: 'CCom',
  },
  ':m ': {
    id: 'minutemen',
    label: 'CMM',
  },
  ':n ': {
    id: 'nanotrasen',
    label: 'NT',
  },
  ':o ': {
    id: 'ai',
    label: 'AI',
  },
  ':s ': {
    id: 'solgov',
    label: 'Sol',
  },
  ':t ': {
    id: 'syndicate',
    label: 'Syndi',
  },
  ':q ': {
    id: 'inteq',
    label: 'IRMG',
  },
  ':v ': {
    id: 'service',
    label: 'Svc',
  },
  ':y ': {
    id: 'pirate',
    label: 'Pir',
  },
} as const;
