import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section } from '../components';
import { LabeledListItem } from '../components/LabeledList';
import { Window } from '../layouts';
import { AIOptions, Options, Toner } from './Photocopier';

export const FaxMachine = (props, context) => {
  const { data } = useBackend(context);

  return (
    <Window
      title="Fax Machine"
      width={300}
      height={data.isAI ? 490 : 415}>
      <Window.Content>
        {data.has_toner ? (
          <Toner />
        ) : (
          <Section title="Toner">
            <Box color="average">
              No inserted toner cartridge.
            </Box>
          </Section>
        )}
        <FaxContent />
        {data.has_item ? (
          <Options />
        ) : (
          <Section title="Options">
            <Box color="average">
              No inserted item.
            </Box>
          </Section>
        )}
        {!!data.isAI && (
          <AIOptions />
        )}
      </Window.Content>
    </Window>
  );
};

const FaxContent = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Section title="Fax Menu"
      buttons={
        <Button
          onClick={() => act('auth')}
          icon={data.authenticated ? "sign-out-alt" : "sign-in-alt"}
          content={data.authenticated ? "Log Out" : "Log In"}
          color={data.authenticated ? "bad" : "good"} />
      }>
      <LabeledList>
        <LabeledListItem label="Authentication">
          <Box color="label">
            {data.authenticated ? data.authenticated : "None"}
          </Box>
        </LabeledListItem>
        <LabeledListItem label="Network">
          <Box color="label">
            {data.network ? data.network : "Disconnected"}
          </Box>
        </LabeledListItem>
        <LabeledListItem label="Currently Sending">
          <Button
            icon={"eject"}
            onClick={() => act('paper')}
            content={data.paper} />
          <Button
            icon={'edit'}
            onClick={() => act('rename')}
            content={"Rename"}
            disabled={!data.paperinserted}
          />
        </LabeledListItem>
        <LabeledListItem label="Sending to">
          <Button
            icon={'print'}
            onClick={() => act('dept')}
            content={data.destination}
            disabled={!data.authenticated} />
        </LabeledListItem>
        <LabeledListItem label="Action">
          <Button
            icon={data.cooldown && data.respectcooldown
              ? 'clock-o'
              : "envelope-o"}
            onClick={() => act('send')}
            disabled={(data.cooldown && data.respectcooldown)
              || (!data.paperinserted)}
            content={data.cooldown && data.respectcooldown
              ? "Realigning"
              : "Send"} />
        </LabeledListItem>
      </LabeledList>
    </Section>
  );
};
