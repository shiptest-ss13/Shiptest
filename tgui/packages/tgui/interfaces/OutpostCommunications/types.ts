export type Data = {
  points: number;
  outpostDocked: boolean;
  blockade: boolean;
  onShip: boolean;
  numMissions: number;
  maxMissions: number;
  shipMissions: Array<Mission>;
  outpostMissions: Array<Mission>;
  message: string;
  highPriorityAssigned: boolean;
  punchard_order: Array<any>;
};

export type PackOrder = {
  ref: string;
  count: number;
};

export type Mission = {
  ref: string;
  name: string;
  desc: string;
  progressStr: string;
  progressPer: number;
  actStr: string;
  value: number;
  remaining: number;
  highPriority: boolean;
};
