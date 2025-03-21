import { filter } from 'common/collections';
import { flow } from 'common/fp';

import { SupplyPack, SupplyCategory } from './types';

/**
 * Take entire supplies tree
 * and return a flat supply pack list that matches search,
 * sorted by name and only the first page.
 * @param {SupplyPack[]} supplies Supplies list, aka Object.values(data.supplies)
 * @param {string} search The search term
 * @returns {SupplyPack[]} The flat list of supply packs.
 */
export function searchForSupplies(
  supplies: SupplyCategory[],
  search: string
): SupplyPack[] {
  const lowerSearch = search.toLowerCase();

  return flow([
    // Flat categories
    (initialSupplies: SupplyCategory[]) =>
      initialSupplies.flatMap((category) => category.packs),
    filter(
      (pack: SupplyPack) =>
        pack.name?.toLowerCase().includes(lowerSearch) ||
        pack.desc?.toLowerCase().includes(lowerSearch)
    ),
    // Just the first page
    (filtered: SupplyPack[]) => filtered.slice(0, 25),
  ])(supplies);
}
