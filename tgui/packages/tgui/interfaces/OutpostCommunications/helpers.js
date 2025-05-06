import { filter } from 'common/collections';
import { flow } from 'tgui-core/fp';

/**
 * Take entire supplies tree
 * and return a flat supply pack list that matches search,
 * sorted by name and only the first page.
 * @param {any[]} supplies Supplies list.
 * @param {string} search The search term
 * @returns {any[]} The flat list of supply packs.
 */
export function searchForSupplies(supplies, search) {
  const lowerSearch = search.toLowerCase();
  return flow([
    // Flat categories
    (initialSupplies) => initialSupplies.flatMap((category) => category.packs),
    // Filter by name or desc
    (flatMapped) =>
      filter(
        flatMapped,
        (pack) =>
          pack.name?.toLowerCase().includes(lowerSearch) ||
          pack.desc?.toLowerCase().includes(lowerSearch),
      ),
    // Just the first page
    (filtered) => filtered.slice(0, 25),
  ])(supplies);
}
