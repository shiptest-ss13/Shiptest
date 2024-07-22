export type CargoData = {
  supply_packs: { [ref: string]: SupplyPack };
  categories: Category;
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

export interface Category {
  [name: string]: string[];
}
