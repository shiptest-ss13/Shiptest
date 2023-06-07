import { getGasColor, getGasFromId, getGasFromPath, getGasLabel } from './constants';

describe('gas helper functions', () => {
  it('should get the proper gas label', () => {
    const gasName = 'antinoblium';
    const gasLabel = getGasLabel(gasName);
    expect(gasLabel).toBe('Anti-Noblium');
  });

  it('should get the proper gas label with a fallback', () => {
    const gasName = 'nonexistent';
    const gasLabel = getGasLabel(gasName, 'fallback');

    expect(gasLabel).toBe('fallback');
  });

  it('should return none if no gas and no fallback is found', () => {
    const gasName = 'nonexistent';
    const gasLabel = getGasLabel(gasName);

    expect(gasLabel).toBe('Nonexistent');
  });

  it('should get the proper gas color', () => {
    const gasName = 'Antinoblium';
    const gasColor = getGasColor(gasName);

    expect(gasColor).toBe('maroon');
  });

  it('should return a string if no gas is found', () => {
    const gasName = 'nonexistent';
    const gasColor = getGasColor(gasName);

    expect(gasColor).toBe('black');
  });

  it('should return the gas object if found', () => {
    const gasId = 'antinoblium';
    const gas = getGasFromId(gasId);

    expect(gas).toEqual({
      id: 'antinoblium',
      path: '/datum/gas/antinoblium',
      name: 'Antinoblium',
      label: 'Anti-Noblium',
      color: 'maroon',
    });
  });

  it('should return undefined if no gas is found', () => {
    const gasId = 'nonexistent';
    const gas = getGasFromId(gasId);

    expect(gas).toBeUndefined();
  });

  it('should return the gas using a path', () => {
    const gasPath = '/datum/gas/antinoblium';
    const gas = getGasFromPath(gasPath);

    expect(gas).toEqual({
      id: 'antinoblium',
      path: '/datum/gas/antinoblium',
      name: 'Antinoblium',
      label: 'Anti-Noblium',
      color: 'maroon',
    });
  });
});
