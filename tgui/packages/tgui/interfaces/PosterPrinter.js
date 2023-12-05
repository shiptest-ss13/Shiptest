import { useBackend } from '../backend';
import { Box, Button, Dropdown, ProgressBar, Section } from '../components';
import { Window } from '../layouts';

export const PosterPrinter = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_paper, has_toner, has_poster } = data;

  return (
    <Window title="PosterPrinter" width={320} height={512}>
      <Window.Content>
        {has_toner ? (
          <Toner />
        ) : (
          <Section title="Toner">
            <Box color="average">No inserted toner cartridge.</Box>
          </Section>
        )}
        {has_paper ? (
          <Options />
        ) : (
          <Section title="Options">
            <Box color="average">No inserted paper.</Box>
          </Section>
        )}
        {has_poster ? (
          <Section title="Remove Poster">
            <Button
              mt={0.5}
              textAlign="center"
              icon="reply"
              onClick={() => act('remove_poster')}
            >
              Remove poster
            </Button>
          </Section>
        ) : (
          <Section title="Remove Poster">
            <Box color="average">No poster printed!</Box>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const Toner = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_toner, max_toner, current_toner } = data;

  const average_toner = max_toner * 0.66;
  const bad_toner = max_toner * 0.33;

  return (
    <Section
      title="Toner"
      buttons={
        <Button
          disabled={!has_toner}
          onClick={() => act('remove_toner')}
          icon="eject"
        >
          Eject
        </Button>
      }
    >
      <ProgressBar
        ranges={{
          good: [average_toner, max_toner],
          average: [bad_toner, average_toner],
          bad: [0, bad_toner],
        }}
        value={current_toner}
        minValue={0}
        maxValue={max_toner}
      />
    </Section>
  );
};

const Options = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_toner, poster_type } = data;

  const posterTypes = [
    'Syndicate',
    'Nanotrasen',
    'Nanotrasen (Retro)',
    'RILENA',
    'SolGov',
  ];
  const selectedType = poster_type ?? 'No Poster Selected';

  return (
    <Section title="Options">
      <Dropdown
        width="100%"
        options={posterTypes}
        selected={selectedType}
        onSelected={(value) =>
          act('choose_type', {
            poster_type: value,
          })
        }
      />
      <Button
        disabled={!has_toner}
        fluid
        icon="images"
        textAlign="center"
        onClick={() => act('print')}
      >
        Print poster
      </Button>
      <Button
        mt={0.5}
        textAlign="center"
        icon="reply"
        fluid
        onClick={() => act('remove')}
      >
        Remove paper
      </Button>
    </Section>
  );
};
