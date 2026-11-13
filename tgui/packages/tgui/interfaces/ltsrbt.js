import { useBackend } from '../backend';
import {
  Box,
  Button,
  Input,
  NumberInput,
  Stack,
  TextArea,
} from '../components';
import { Window } from '../layouts';

// type Data = {
//   name: string;
//   price: number;
//   min_price: number;
//   max_price: number;
//   loaded_icon: string;
//   desc: string;
// };

export const LTSRBT = (props, context) => {
  const { act, data } = useBackend(context);
  const { name, price, min_price, max_price, desc, seller_id, id_locked } = data;

  return (
    <Window width={600} height={380} theme="hackerman">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            {!id_locked && <Input
              width="80%"
              value={seller_id}
              placeholder="Set a permanent seller ID. Don't use your real name, dumbass."
              onChange={(e, value) =>
                act('change_id', {
                  value: value,
                })
              }
            />
            }
            {!id_locked && <Button.Confirm
              fluid
              disabled={id_locked}
              width="80%"
              icon="truck-arrow-right"
              content="Set Seller ID"
              onClick={() => act('set_id')}
            />}
           {!! id_locked && <Box inline bold> Seller ID: {seller_id} </Box>}
          </Stack.Item>
            <Stack.Divider />
            <Stack.Item>
            <Input
              width="80%"
              value={name}
              placeholder="Insert a name"
              onChange={(e, value) =>
                act('change_name', {
                  value: value,
                })
              }
            />
            <NumberInput
              step={1}
              width="20%"
              value={price}
              minValue={min_price}
              maxValue={max_price}
              unit="cr"
              onChange={(e, value) =>
                act('change_price', {
                  value: value,
                })
              }
            />
            </Stack.Item>
          <Stack.Divider />
          <Stack.Item grow>
            <TextArea
              height="90%"
              value={desc}
              placeholder="Insert a description (or don't)"
              onChange={(e, value) =>
                act('change_desc', {
                  value: value,
                })
              }
            />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <Button.Confirm
              fluid
              icon="truck-arrow-right"
              content="Place on Market"
              onClick={() => act('place_on_market')}
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
