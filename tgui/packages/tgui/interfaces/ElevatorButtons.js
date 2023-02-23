import { useBackend } from '../backend';
import {
  Button,
  Table,
} from '../components';
import { Window } from '../layouts';

export const ElevatorButtons = (props, context) => {
  return (
    <Window width={620} height={620} resizable>
      <Window.Content scrollable>
        <ElevatorButtonsContent />
      </Window.Content>
    </Window>
  );
};

const ElevatorButtonsContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    floors = [],
  } = data;
  // you know this TGUI code sucks because it looks like actual fucking code
  // burn all functional languages
  const rows = [];
  // iterate through the floors, starting at the SECOND floor,
  // collecting groups of 3
  for(let i = 0; i < (floors.length - 1); i++) {
    if(!(i % 3)) {
      rows[Math.floor(i)] = [];
    }
    rows[Math.floor(i)][i % 3] = floors[i+1];
  }

  return (
    <Table>
      {rows.map((row) => (
      <Table.Row
        key={row}>
        {row.map((floor) => (
        <Table.Cell
          key={floor}>
          <Button.Checkbox
            checked={floor.is_dest}
            content={floor.num}
            onClick={() => act('set_dest', {
              ref: floor.ref,
            })}
          />
        </Table.Cell>
        ))}
      </Table.Row>
      ))}
      <Table.Row>
        {floors.length > 0 && (
        <Table.Cell>
          <Button.Checkbox
            checked={floors[0].is_dest}
            content={"★1"}
            onClick={() => act('set_dest', {
              ref: floors[0].ref,
            })}
          />
        </Table.Cell>
        )}
        <Table.Cell>
          {/* // DEBUG: add color logic, disabled status to open and close door buttons */}
          <Button
            content={"◀|▶"}
            onClick={() => act('open_doors')}
          />
        </Table.Cell>
        <Table.Cell>
          <Button
            content={"▶|◀"}
            onClick={() => act('close_doors')}
          />
        </Table.Cell>
      </Table.Row>
    </Table>
  );
};
