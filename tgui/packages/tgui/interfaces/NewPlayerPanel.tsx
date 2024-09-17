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
  Flex,
} from '../components';
import { Window } from '../layouts';

type PlayerPanelData = {
  motd: string;
  game_started: boolean;
};

export const NewPlayerPanel = (props, context) => {
  const { act, data } = useBackend<PlayerPanelData>(context);
  return (
    <Window title="New Player Panel" width={500} height={300}>
      <Window.Content>
        <Flex direction="row">
          <Stack vertical p="8px" textAlign="center">
            <Stack.Item>
              <Button onClick={() => act('show_preferences')}>
                Setup Character
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button disabled={data.game_started} onClick={() => act('join_game')}>Join Game</Button>
            </Stack.Item>
            <Stack.Item>
              <Button onClick={() => act('manifest')}>View Manifest</Button>
            </Stack.Item>
            <Stack.Item>
              <Button onClick={() => act('observe')}>Observe</Button>
            </Stack.Item>
            <Stack.Item>
              <Button>Old UI</Button>
            </Stack.Item>
          </Stack>
          <Box dangerouslySetInnerHTML={{ __html: data.motd }} />
        </Flex>
      </Window.Content>
    </Window>
  );
};
