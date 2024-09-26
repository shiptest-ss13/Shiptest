export type Data = {
  missions: Array<Mission>;
};


export type Mission = {
  ref: string;
  actStr: string;
  name: string;
  author: string;
  desc: string;
  rewards: string;
  faction: string;
  x: number;
  y: number;
  progressStr: string;
  remaining: number;
  duration: number;
  timeStr: string;
};
