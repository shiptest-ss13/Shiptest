export type CargoData = {
  supply_packs: SupplyPack[];
  shopping_cart: [];
};

export type SupplyPack = {
  ref: string;
  name: string;
  group: string;
  cost: string;
  id: string;
  desc: string;
};
