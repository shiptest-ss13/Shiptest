export type Data = {
  missions: Array<Mission>;
  pad: Boolean;
  id_inserted: Boolean;
  sending: Boolean;
};

export type Mission = {
  ref: string;
  actStr: string;
  name: string;
  author: string;
  desc: string;
  reward: string;
  faction: string;
  location: string;
  x: number;
  y: number;
  progressStr: string;
  remaining: number;
  duration: number;
  timeStr: string;
  canTurnIn: Boolean;
  validItems: Array<string>;
};

