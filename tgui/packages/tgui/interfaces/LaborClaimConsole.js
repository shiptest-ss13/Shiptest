import { Box, Button, LabeledList, Section, Table } from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const LaborClaimConsole = (props) => {
  const { act, data } = useBackend();
  const { can_go_home, id_points, ores, status_info, unclaimed_points } = data;
  return (
    <Window width={315} height={430}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Status">{status_info}</LabeledList.Item>
            <LabeledList.Item label="Points">{id_points}</LabeledList.Item>
            <LabeledList.Item
              label="Unclaimed points"
              buttons={
                <Button
                  content="Claim points"
                  disabled={!unclaimed_points}
                  onClick={() => act('claim_points')}
                />
              }
            >
              {unclaimed_points}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Material values">
          <Table>
            <Table.Row header>
              <Table.Cell>Material</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                Value
              </Table.Cell>
            </Table.Row>
            {ores.map((ore) => (
              <Table.Row key={ore.ore}>
                <Table.Cell>{toTitleCase(ore.ore)}</Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Box color="label" inline>
                    {ore.value}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
