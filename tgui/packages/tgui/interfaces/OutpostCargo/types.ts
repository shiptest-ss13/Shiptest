export type CargoData = {
  supply_packs: Record<string, SupplyCategory>;
  shopping_cart: [];
};

export type SupplyCategory = {
  name: string;
  packs: SupplyPack[];
};

export type SupplyPack = {
  ref: string;
  name: string;
  group: string;
  cost: string;
  id: string;
  desc: string;
};
