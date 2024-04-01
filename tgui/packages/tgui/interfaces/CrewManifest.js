import { decodeHtmlEntities } from 'common/string';
import { useBackend } from '../backend';
import { Icon, Section, Table } from '../components';
import { Window } from '../layouts';

export const CrewManifest = (props, context) => {
  const {
    data: { manifest },
  } = useBackend(context);

  return (
    <Window title="Crew Manifest" width={350} height={500}>
      <Window.Content scrollable>
        {Object.entries(manifest).map(([department, crew]) => (
          <Section
            className={'CrewManifest--' + department}
            key={department}
            title={decodeHtmlEntities(department)}
          >
            <Table>
              {Object.entries(crew).map(([crewIndex, crewMember]) => (
                <Table.Row key={crewIndex}>
                  <Table.Cell className={'CrewManifest__Cell'}>
                    {crewMember.name}
                  </Table.Cell>
                  <Table.Cell
                    className={
                      'CrewManifest__Cell CrewManifest__Cell--' +
                      (crewMember.rank === 'Captain' ? 'Captain' : 'Command')
                    }
                    collapsing
                  >
                    {!!crewMember.officer && (
                      <Icon
                        name={
                          crewMember.rank === 'Captain' ? 'star' : 'chevron-up'
                        }
                      />
                    )}
                  </Table.Cell>
                  <Table.Cell
                    className={'CrewManifest__Cell'}
                    collapsing
                    color="label"
                  >
                    {crewMember.rank}
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        ))}
      </Window.Content>
    </Window>
  );
};
