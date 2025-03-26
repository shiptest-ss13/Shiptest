import { useBackend } from '../backend';
import { Button, Flex, LabeledList, Section } from '../components';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

export const TurretControl = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    allow_manual_control,
    manual_control,
    silicon_user,
    lethal,
    enabled,
    dangerous_only,
    retaliate,
    shoot_fauna,
    shoot_humans,
    shoot_silicons,
    only_nonfaction,
    only_specificfaction,
  } = data;
  const locked = data.locked && !silicon_user;

  return (
    <Window width={305} height={275}>
      <Window.Content>
        <InterfaceLockNoticeBox />
        <Section
          title="Status"
          buttons={
            !!allow_manual_control &&
            !!silicon_user && (
              <Button
                icon={manual_control ? 'wifi' : 'terminal'}
                content={
                  manual_control ? 'Remotely Controlled' : 'Manual Control'
                }
                disabled={manual_control}
                color="bad"
                onClick={() => act('manual')}
              />
            )
          }
        >
          <LabeledList>
            <LabeledList.Item label="Turret Status">
              <Button
                icon={enabled ? 'power-off' : 'times'}
                content={enabled ? 'Enabled' : 'Disabled'}
                selected={enabled}
                disabled={locked}
                onClick={() => act('power')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Turret Mode">
              <Button
                icon={lethal ? 'exclamation-triangle' : 'minus-circle'}
                content={lethal ? 'Lethal' : 'Stun'}
                color={lethal ? 'bad' : 'average'}
                disabled={locked}
                onClick={() => act('mode')}
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Target Settings">
          <Flex>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={dangerous_only}
                content="Only Dangerous"
                tooltip="Only shoot at dangerous targets."
                disabled={locked}
                onClick={() => act('toggle_dangerous')}
              />
            </Flex.Item>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={retaliate}
                content="Retaliate"
                tooltip="Retaliate against attackers."
                disabled={locked}
                onClick={() => act('toggle_retaliate')}
              />
            </Flex.Item>
          </Flex>
          <Flex>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={shoot_fauna}
                content="Fauna"
                tooltip="Allow shooting at unidentified life."
                disabled={locked}
                onClick={() => act('toggle_fauna')}
              />
            </Flex.Item>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={shoot_humans}
                content="Humans"
                tooltip="Allow shooting at humans."
                disabled={locked}
                onClick={() => act('toggle_humans')}
              />
            </Flex.Item>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={shoot_silicons}
                content="Silicons"
                tooltip="Allow shooting at silicons."
                disabled={locked}
                onClick={() => act('toggle_silicons')}
              />
            </Flex.Item>
          </Flex>
          <Flex>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={only_nonfaction}
                content="Any other faction"
                tooltip="Only targets other factions."
                disabled={locked}
                onClick={() => act('toggle_nonfaction')}
              />
            </Flex.Item>
            <Flex.Item grow={1}>
              <Button.Checkbox
                fluid
                checked={only_specificfaction}
                content="Specific factions"
                tooltip="Only targets specific factions."
                disabled={locked}
                onClick={() => act('toggle_specificfaction')}
              />
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
