import { marked } from 'marked';
import { useBackend, useLocalState } from '../backend';
import { Input, Stack, Box, Section, Button } from '../components';
import { Window } from '../layouts';
import { walkTokens } from './common/Markdown';

type MarkdownEditorContext = {
  editorName: string;
  inputText: string;
};

export const MarkdownEditor = (props, context) => {
  const { act, data } = useBackend<MarkdownEditorContext>(context);

  const [text, setText] = useLocalState(context, 'text', data.inputText);
  const unchanged = text === data.inputText;

  marked.use({
    breaks: true,
    gfm: true,
    smartypants: true,
    walkTokens: walkTokens,
    // Once assets are fixed might need to change this for them
    baseUrl: 'thisshouldbreakhttp',
  });

  return (
    <Window
      title={data.editorName + (unchanged ? '' : ' (Changed)')}
      width={500}
      height={300}
    >
      <Window.Content>
        <Stack fill>
          <Stack.Item grow>
            <Input
              multiline
              value={data.inputText}
              onChange={(value) => setText(value)}
            />
          </Stack.Item>
          <Stack.Item grow>
            <Section
              title="Preview"
              fill
              fitted
              scrollable
              buttons={
                <>
                  <Button
                    icon="save"
                    color="good"
                    onClick={() => act('saveInput', { text: text })}
                    disabled={unchanged}
                  />
                  <Button
                    icon="undo"
                    color="bad"
                    onClick={() => setText(data.inputText)}
                    disabled={unchanged}
                  />
                </>
              }
            >
              <Box
                dangerouslySetInnerHTML={{
                  __html: marked(text),
                }}
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
