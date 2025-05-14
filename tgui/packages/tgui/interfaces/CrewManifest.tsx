import { decodeHtmlEntities } from 'common/string';
import { useBackend } from '../backend';
import { Icon, StyleableSection, Table } from '../components';
import { Window } from '../layouts';

type CrewEntry = {
  name: string;
  rank: string;
  officer: boolean;
};

type CrewManifestData = {
  manifest: {
    [shipName: string]: {
      color: string;
      mode: 'Locked' | 'Apply' | 'Open';
      crew: CrewEntry[];
    };
  };
};

export const CrewManifest = (props, context) => {
  const { data } = useBackend<CrewManifestData>(context);
  const { manifest } = data;

  return (
    <Window title="Crew Manifest" width={350} height={500}>
      <Window.Content scrollable>
        {Object.entries(manifest).map(([shipName, shipInfo]) => (
          <StyleableSection
            titleStyle={{ 'border-color': shipInfo.color }}
            textStyle={{ color: shipInfo.color }}
            key={shipName}
            title={decodeHtmlEntities(shipName)}
          >
            <Table>
              {shipInfo.crew.map((crewMember, crewIndex) => (
                <Table.Row key={crewIndex}>
                  <Table.Cell className={'CrewManifest__Cell'}>
                    {crewMember.name}
                  </Table.Cell>
                  <Table.Cell
                    className={'CrewManifest__Cell CrewManifest__Icons'}
                    collapsing
                  >
                    {!!crewMember.officer && (
                      <Icon
                        name={crewIndex === 1 ? 'star' : 'chevron-up'}
                        className={
                          'CrewManifest__Icon CrewManifest__Icon--' +
                          (crewIndex === 1 ? 'Captain' : 'Officer')
                        }
                      />
                    )}
                  </Table.Cell>
                  <Table.Cell
                    className={'CrewManifest__Cell CrewManifest__Cell--Rank'}
                    collapsing
                    color="label"
                  >
                    {crewMember.rank}
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </StyleableSection>
        ))}
      </Window.Content>
    </Window>
  );
};
