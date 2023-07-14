import { useBackend } from '../backend';
import { Button, Table } from '../components';
import { Window } from '../layouts';

export const ElevatorButtons = (props, context) => {
  return (
    <Window width={200} height={400} resizable>
      <Window.Content scrollable>
        <ElevatorButtonsContent />
      </Window.Content>
    </Window>
  );
};

const ElevatorButtonsContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { floors = [] } = data;
  // you know this TGUI code sucks because it looks like actual fucking code
  // burn all functional languages
  const rows = [];
  // iterate through the floors, starting at the SECOND floor,
  // collecting groups of 3
  for (let i = 0; i < floors.length - 1; i++) {
    if (!(i % 3)) {
      rows[Math.floor(i / 3)] = [];
    }
    rows[Math.floor(i / 3)][i % 3] = floors[i + 1];
  }
  rows.reverse(); // we want the array to start at the highest, with lowest at the bottom

  return (
    <Table>
      {rows.map((row) => (
        <Table.Row key={row}>
          {row.map((floor) => (
            <Table.Cell key={floor}>
              <Button.Checkbox
                diabled={floor.ref === null}
                checked={floor.is_dest}
                onClick={() =>
                  act('set_dest', {
                    ref: floor.ref,
                  })
                }
              >
                {(floor.ref === null && <s>{floor.num}</s>) || floor.num}
              </Button.Checkbox>
            </Table.Cell>
          ))}
        </Table.Row>
      ))}
      <Table.Row>
        {floors.length > 0 && (
          <Table.Cell>
            <Button.Checkbox
              diasbled={floors[0].ref === null}
              checked={floors[0].is_dest}
              onClick={() =>
                act('set_dest', {
                  ref: floors[0].ref,
                })
              }
            >
              {(floors[0].ref === null && <s>{'★' + floors[0].num}</s>) ||
                '★' + floors[0].num}
            </Button.Checkbox>
          </Table.Cell>
        )}
        <Table.Cell>
          {/* these don't do anything; it's unfinished. oh well */}
          <Button disabled content={'◀|▶'} onClick={() => act('open_doors')} />
        </Table.Cell>
        <Table.Cell>
          {/* interestingly, this button doesn't work even on real elevators */}
          <Button disabled content={'▶|◀'} onClick={() => act('close_doors')} />
        </Table.Cell>
      </Table.Row>
    </Table>
  );
};
