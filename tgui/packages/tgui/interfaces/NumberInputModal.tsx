import { Box, Button, RestrictedInput, Section, Stack } from '../components';
import { useLocalState } from '../backend';
import { KEY } from '../../common/keys';
import type { BooleanLike } from '../../common/react';

import { InfernoKeyboardEvent } from 'inferno';
import { useBackend } from '../backend';
import { Window } from '../layouts';
import { InputButtons } from './common/InputButtons';
import { Loader } from './common/Loader';

type Data = {
  init_value: number;
  max_value: number;
  min_value: number;
  message: string;
  title: string;
  large_buttons: BooleanLike;
  round_value: BooleanLike;
  timeout: number;
};

export const NumberInputModal = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const {
    init_value,
    large_buttons,
    max_value = 10000,
    message = '',
    min_value = 0,
    round_value,
    timeout,
    title,
  } = data;

  const [value, setValue] = useLocalState<number>(context, title, init_value);

  // Dynamically changes the window height based on the message.
  const windowHeight =
    140 +
    (message.length > 30 ? Math.ceil(message.length / 3) : 0) +
    (message.length && large_buttons ? 5 : 0);

  return (
    <Window title={title} width={270} height={windowHeight}>
      {timeout && <Loader value={timeout} />}
      <Window.Content
        onKeyDown={(event: InfernoKeyboardEvent<HTMLDivElement>) => {
          const keyCode = window.event ? event.which : event.keyCode;
          if (keyCode === KEY.Enter) {
            act('submit', { entry: value });
          }
          if (keyCode === KEY.Escape) {
            act('cancel');
          }
        }}
      >
        <Section fill>
          <Stack fill vertical>
            <Stack.Item grow>
              <Box color="label">{message}</Box>
            </Stack.Item>
            <Stack.Item>
              <Stack fill>
                <Stack.Item>
                  <Button
                    disabled={value === min_value}
                    icon="angle-double-left"
                    onClick={() => setValue(min_value ?? 0)}
                    tooltip={min_value ? `Min (${min_value})` : 'Min'}
                  />
                </Stack.Item>

                <Stack.Item>
                  <Button
                    icon="angle-down"
                    disabled={value <= min_value}
                    onClick={() => setValue(value - 1)}
                  />
                </Stack.Item>

                <Stack.Item grow>
                  <RestrictedInput
                    autoFocus
                    autoSelect
                    fluid
                    allowFloats={!round_value}
                    minValue={min_value}
                    maxValue={max_value}
                    onChange={(raw, valid) => setValue(valid)}
                    value={value}
                  />
                </Stack.Item>

                <Stack.Item>
                  <Button
                    icon="angle-up"
                    disabled={value >= max_value}
                    onClick={() => setValue(value + 1)}
                  />
                </Stack.Item>

                <Stack.Item>
                  <Button
                    disabled={value === max_value}
                    icon="angle-double-right"
                    onClick={() => setValue(max_value ?? 10000)}
                    tooltip={max_value ? `Max (${max_value})` : 'Max'}
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    disabled={value === init_value}
                    icon="redo"
                    onClick={() => setValue(init_value ?? 0)}
                    tooltip={init_value ? `Reset (${init_value})` : 'Reset'}
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <InputButtons input={value} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
