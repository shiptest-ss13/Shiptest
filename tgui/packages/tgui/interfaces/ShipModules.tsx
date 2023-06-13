import { useBackend, useLocalState } from '../backend';
import { Button, NoticeBox, Section, Stack, Tabs } from '../components';
import { Window } from '../layouts';

type ShipModulesData = {
  modules: ModuleData[];
};

type ModuleData = {
  ref: string;
  name: string;
  info: string;
  enabled: boolean;
  configurable: boolean;
};

export const ShipModules = (_: any, context: any) => {
  const { data } = useBackend<ShipModulesData>(context);

  const [tab, setTab] = useLocalState(context, 'tab', 'active');

  let rendering: ModuleData[] = [];
  for (let module of data.modules) {
    if (module.enabled && tab === 'active') {
      rendering.push(module);
    }
    if (!module.enabled && tab === 'disabled') {
      rendering.push(module);
    }
  }

  return (
    <Window title="Ship Modules" width={400} height={400}>
      <Window.Content scrollable>
        <Section
          title={`${tab === 'active' ? 'Active' : 'Disabled'} Modules`}
          buttons={
            <Tabs>
              <Tabs.Tab
                selected={tab === 'active'}
                onClick={() => setTab('active')}
              >
                Active
              </Tabs.Tab>
              <Tabs.Tab
                selected={tab === 'disabled'}
                onClick={() => setTab('disabled')}
              >
                Disabled
              </Tabs.Tab>
            </Tabs>
          }
        >
          <Stack fill vertical>
            {(rendering.length === 0 && (
              <NoticeBox>
                There are no {tab === 'active' ? 'active' : 'disabled'} modules.
              </NoticeBox>
            )) ||
              rendering.map((module, i) => <Module key={i} module={module} />)}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

type ModuleProps = {
  module: ModuleData;
};

const Module = (props: ModuleProps, context: any) => {
  const { ref, name, info, enabled, configurable } = props.module;
  const { act } = useBackend(context);
  return (
    <>
      <Stack.Item>
        <pre>
          {name}
          &nbsp;
          <Button
            icon={enabled ? 'toggle-on' : 'toggle-off'}
            onClick={() => act('toggle', { ref: ref })}
            color={enabled ? 'green' : 'red'}
          />
          <Button
            icon="trash"
            color="yellow"
            onClick={() => act('remove', { ref: ref })}
          />
          <Button
            disabled={!configurable}
            icon="wrench"
            onClick={() => act('configure', { ref: ref })}
          />
        </pre>
        <pre>Status: {info}</pre>
      </Stack.Item>
      <hr />
    </>
  );
};
