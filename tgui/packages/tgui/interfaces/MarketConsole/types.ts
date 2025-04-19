export type CargoData = {
  supply_packs: Record<string, SupplyCategory>;
  shopping_cart: CartOrder[];
  account_holder: string;
  account_balance: number;
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
  discountedcost: number;
  discountpercent: number;
  faction_locked: Boolean;
  stock: any;
  desc: string;
  no_bundle: Boolean;
};

export type CartOrder = {
  ref: string;
  name: string;
  cost: number;
  count: number;
};
