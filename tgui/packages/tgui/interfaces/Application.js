import { Button, Stack, TextArea } from 'tgui-core/components';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

export const Application = (props) => {
  const { act, data } = useBackend();
  const [message, setMessage] = useLocalState('message', '');
  const [showCkey, setShowCkey] = useLocalState('showCkey', false);
  const { ship_name, player_name } = data;

  return (
    <Window
      title={ship_name + ' application as ' + player_name}
      width={500}
      height={600}
    >
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            <p>
              This ship is <b>application-only.</b> To join, your application
              must be approved by the current ship owner. This is an
              <b>OOC</b> utility.
              <br />
              <br />
              <b>You only get one application per ship.</b> Different characters
              use the same application.
              <br />
              <br />
              Applications are sorted via ckey, but your ckey is only shown to
              the ship owner if this setting is enabled:
              <br />
              <Button.Checkbox
                content="Show ckey to ship owner"
                checked={showCkey}
                onClick={() => setShowCkey(!showCkey)}
              />
            </p>
            <TextArea
              value={message}
              fluid
              height={25}
              maxLength={1024}
              placeholder="Please enter your application. No more than 1024 characters."
              onChange={(e, input) => setMessage(input)}
            />
          </Stack.Item>
          <Stack.Item>
            <Stack textAlign="center">
              <Stack.Item grow basis={0}>
                <Button
                  fluid
                  content="Cancel"
                  color="bad"
                  lineHeight={2}
                  onClick={() => act('cancel')}
                />
              </Stack.Item>
              <Stack.Item grow basis={0}>
                <Button
                  fluid
                  content="Submit"
                  color="good"
                  lineHeight={2}
                  onClick={() =>
                    act('submit', {
                      text: message,
                      ckey: showCkey,
                    })
                  }
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
