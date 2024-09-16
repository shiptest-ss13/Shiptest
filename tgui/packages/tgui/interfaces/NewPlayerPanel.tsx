import { useBackend } from '../backend';
import {
  Button,
  LabeledList,
  NumberInput,
  Section,
  NoticeBox,
  Input,
  Table,
  Box,
  Stack,
} from '../components';
import { Window } from '../layouts';

export const NewPlayerPanel = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window title="New Player Panel" width={250} height={300}>
      <Window.Content>
        <Stack vertical p="8px" textAlign="center">
          <Stack.Item>
            <Button onClick={() => act('show_preferences')}>
              Setup Character
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('join_game')}>Join Game</Button>
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('manifest')}>View Manifest</Button>
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('observe')}>Observe</Button>
          </Stack.Item>
          <Stack.Item>
            <Button onClick={() => act('motd')}>MOTD</Button>
            <Button>Old UI</Button>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
