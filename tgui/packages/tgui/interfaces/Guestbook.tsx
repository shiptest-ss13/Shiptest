import { Box, Button, Input, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { useLocalState } from '../backend';
import { Window } from '../layouts';

type Info = {
  names: NameData[];
};

type NameData = {
  real_name: string;
  given_name: string;
};

export const Guestbook = (props) => {
  const { act, data } = useBackend<Info>();
  const { names = [] } = data;

  const [lastNameBeforeEdit, setLastNameBeforeEdit] = useLocalState<
    string | null
  >('lastNameBeforeEdit', null);

  return (
    <Window title="Guestbook" width={400} height={500}>
      <Window.Content>
        {(!names.length && <Section>{'No known names!'}</Section>) || (
          <Stack vertical fill scrollable>
            {names.map((name) => (
              <Stack.Item key={name.real_name}>
                <Section fill width="100%">
                  <Button
                    width="80%"
                    captureKeys={lastNameBeforeEdit !== name.real_name}
                    onClick={() => {
                      setLastNameBeforeEdit(name.real_name);
                    }}
                  >
                    {(lastNameBeforeEdit === name.real_name && (
                      <Input
                        onEnter={(e, value) => {
                          act('rename_guest', {
                            real_name: name.real_name,
                            new_name: value,
                          });
                          setLastNameBeforeEdit(null);
                        }}
                        onEscape={() => {
                          setLastNameBeforeEdit(null);
                        }}
                        value={name.given_name}
                      />
                    )) || <Box>{name.given_name}</Box>}
                  </Button>
                  <Button
                    icon="trash"
                    onClick={() => {
                      act('delete_guest', {
                        real_name: name.real_name,
                      });
                    }}
                    color={'bad'}
                  >
                    Forget
                  </Button>
                </Section>
              </Stack.Item>
            ))}
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};
