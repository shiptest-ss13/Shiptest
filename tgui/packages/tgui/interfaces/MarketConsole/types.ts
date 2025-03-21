export type CargoData = {
  supply_packs: Record<string, SupplyCategory>;
  shopping_cart: CartOrder[];
};

export type SupplyCategory = {
  name: string;
  packs: SupplyPack[];
};

export type SupplyPack = {
  ref: string;
  name: string;
  group: string;
  cost: number;
  base_cost: number;
  desc: string;
};

export type CartOrder = {
  ref: string;
  name: string;
  cost: number;
  base_cost: number;
  count: number;
};
