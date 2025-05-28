export type PlantAnalyzerData = {
  scan_target: string;
  tray: TrayData;
  seed: SeedData;
  cycle_seconds: number;
  trait_db: TraitData[];
};

export type TraitData = {
  path: string;
  name: string;
  description: string;
};

export type MutationData = {
  type: string;
  name: string;
  desc: string;
};

export type TrayData = {
  name: string;
  weeds: number;
  pests: number;
  toxic: number;
  water: number;
  maxwater: number;
  nutrients: number;
  maxnutri: number;
  age: number;
  status: string;
  self_sustaining: boolean;
};

export type SeedData = {
  name: number;
  lifespan: number;
  endurance: number;
  maturation: number;
  production: number;
  yield: number;
  potency: number;
  instability: number;
  weed_rate: number;
  weed_chance: number;
  rarity: number;
  genes: string[];
  mutatelist: MutationData[];
  distill_reagent: string;
  juice_result: [];
  grind_results: ReagentData[];
};

export type ReagentData = {
  name: string;
  desc: string;
  amount: number;
};
