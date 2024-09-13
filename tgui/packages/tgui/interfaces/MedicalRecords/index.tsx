import { useBackend } from 'tgui/backend';
import { Box, Button, Icon, NoticeBox, Stack } from 'tgui/components';
import { Window } from 'tgui/layouts';

import { MedicalRecordsData } from './types';

import { MedicalRecordTabs } from './RecordTabs';
import { MedicalRecordView } from './RecordView';

export const MedicalRecords = (props, context) => {
  const { data } = useBackend<MedicalRecordsData>(context);
  const { authenticated, library_name } = data;

  const console_title = library_name + " Medical Records";

  return (
    <Window title={console_title} width={750} height={550}>
      <Window.Content>
        <Stack fill>
          {!authenticated ? <UnauthorizedView /> : <AuthView />}
        </Stack>
      </Window.Content>
    </Window>
  );
};

const UnauthorizedView = (props, context) => {
  const { act } = useBackend(context);
  return (
    <Stack.Item grow>
      <Stack fill vertical>
        <Stack.Item grow />
        <Stack.Item align="center" grow={2}>
          <Icon color="teal" name="staff-snake" size={15} />
        </Stack.Item>
        <Stack.Item align="center" grow>
          <Box color="good" fontSize="18px" bold mt={5}>
            NTNet Records System
          </Box>
        </Stack.Item>
        <Stack.Item>
          <NoticeBox align="right">
            You are not logged in.
            <Button ml={2} icon="lock-open" onClick={() => act('login')}>
              Login
            </Button>
          </NoticeBox>
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

const AuthView = (props, context) => {
  const { data, act } = useBackend(context);

  return (
    <>
      <Stack.Item grow>
        <MedicalRecordTabs />
      </Stack.Item>
      <Stack.Item grow={2}>
        <Stack fill vertical>
          <Stack.Item grow>
            <MedicalRecordView />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox align="right" info>
              Secure Your Workspace.
              <Button
                align="right"
                icon="lock"
                color="good"
                ml={2}
                onClick={() => act('logout')}
              >
                Log Out
              </Button>
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </>
  );
};
