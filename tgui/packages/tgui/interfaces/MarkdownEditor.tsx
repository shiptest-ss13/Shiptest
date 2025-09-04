import { marked } from 'marked';
import { useBackend, useLocalState } from '../backend';
import {
  Stack,
  Box,
  Section,
  Button,
  TextArea,
  NoticeBox,
} from '../components';
import { Window } from '../layouts';
import { walkTokens } from './common/Markdown';

type MarkdownEditorContext = {
  editorName: string;
  inputText: string;
  placeholder: string;
  maxLength: string;
  prompt: string;
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
      width={750}
      height={500}
    >
      <Window.Content>
        {data.prompt && <NoticeBox info>{data.prompt}</NoticeBox>}
        <Stack fill>
          <Stack.Item grow>
            <TextArea
              autoFocus
              height={'100%'}
              value={data.inputText}
              maxLength={data.maxLength}
              placeholder={data.placeholder}
              onInput={(_, value: string) => setText(value)}
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
                  >
                    Save
                  </Button>
                  <Button
                    icon="undo"
                    color="bad"
                    onClick={() => setText(data.inputText)}
                    disabled={unchanged}
                  >
                    Reset
                  </Button>
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
