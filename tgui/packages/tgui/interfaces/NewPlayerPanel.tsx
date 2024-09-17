import { useBackend } from '../backend';
import { Button, Section, Box, Stack, Flex } from '../components';
import { Window } from '../layouts';

type PlayerPanelData = {
  motd: string;
  game_started: boolean;
  character_name: string | null;
  player_polls: number;
  time_to_start: number | string;
};

export const NewPlayerPanel = (props, context) => {
  const { act, data } = useBackend<PlayerPanelData>(context);
  return (
    <Window title="New Player Panel" width={500} height={300} canClose={false}>
      <Window.Content>
        <Flex direction="row" grow>
          <Stack vertical p="8px" textAlign="center">
            <Stack.Item>
              <Flex direction="column">
                <Button onClick={() => act('show_preferences')}>
                  Setup Character
                </Button>
                <Box>{data.character_name ? data.character_name : null}</Box>
              </Flex>
            </Stack.Item>
            <Stack.Item>
              <Button onClick={() => act('manifest')}>View Manifest</Button>
            </Stack.Item>
            <Stack.Item>
              <Button
                disabled={!data.game_started}
                onClick={() => act('join_game')}
              >
                Ship Select
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button onClick={() => act('observe')}>Observe</Button>
            </Stack.Item>
            {!data.game_started ? (
              <Box>Time to start: {data.time_to_start}</Box>
            ) : null}
            {data.player_polls ? (
              <Stack.Item>
                <Button onClick={() => act('view_polls')}>
                  Player Polls: {data.player_polls} open
                </Button>
              </Stack.Item>
            ) : null}
          </Stack>
          <Section
            scrollable
            height={20}
            m={1}
            p={1}
            dangerouslySetInnerHTML={{ __html: data.motd }}
          />
        </Flex>
      </Window.Content>
    </Window>
  );
};
