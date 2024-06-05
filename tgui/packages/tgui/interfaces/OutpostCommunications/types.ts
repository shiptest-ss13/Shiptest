export type Data = {
  points: number;
  outpostDocked: boolean;
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
  actStr: string;
  name: string;
  desc: string;
  progressStr: string;
  value: number;
  remaining: number;
  duration: number;
  timeStr: string;
};
