export type Data = {
  points: number;
  outpostDocked: boolean;
  blockade: boolean;
  onShip: boolean;
  numMissions: number;
  maxMissions: number;
  shipMissions: Array<Mission>;
  outpostMissions: Array<Mission>;
  beaconZone: string;
  beaconName: string;
  hasBeacon: boolean;
  usingBeacon: boolean;
  message: string;
  printMsg: string;
  canBuyBeacon: boolean;
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
};
