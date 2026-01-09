import { BooleanLike } from '../../../common/react';

export type Antagonist = Observable & { antag: string; antag_group: string };

export type AntagGroup = [string, Antagonist[]];

export type OrbitData = {
  alive: Observable[];
  antagonists: Antagonist[];
  critical: Critical[];
  dead: Observable[];
  ghosts: Observable[];
  ships: Observable[];
  misc: Observable[];
  npcs: Observable[];
  orbiting: Observable | null;
  autoObserve: boolean;
};

export type Observable = {
  full_name: string;
  ref: string;
  // Optionals
} & Partial<{
  client: BooleanLike;
  extra: string;
  health: number;
  icon: string;
  job: string;
  name: string;
  orbiters: number;
}>;

type Critical = {
  extra: string;
  full_name: string;
  ref: string;
};
