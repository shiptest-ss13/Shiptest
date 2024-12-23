import { marked } from 'marked';
import { useBackend } from '../backend';
import { Box, Section, Stack } from '../components';
import { Window } from '../layouts';
import { walkTokens } from './common/Markdown';

type FlavorTextContext = {
  characterName: string;
  portraitUrl: string;
  portraitSource: string;
  flavorText: string;
};

export const FlavorText = (props, context) => {
  const { data } = useBackend<FlavorTextContext>(context);

  marked.use({
    breaks: true,
    gfm: true,
    smartypants: true,
    walkTokens: walkTokens,
    // Once assets are fixed might need to change this for them
    baseUrl: 'thisshouldbreakhttp',
  });

  return (
    <Window title={data.characterName} width={500} height={300}>
      <Window.Content>
        <Stack fill>
          {data.portraitUrl && (
            <Stack.Item grow>
              <Section title="Portrait" fill>
                <Box className="FlavorText__Portrait">
                  <img src={data.portraitUrl} />
                </Box>
                <Box italic textAlign="center">
                  {data.portraitSource}
                </Box>
              </Section>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Section title="Flavor Text" fill>
              <Box
                dangerouslySetInnerHTML={{
                  __html: marked(data.flavorText),
                }}
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
