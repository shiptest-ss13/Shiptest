import { useBackend, useLocalState } from '../backend';
import { Button, Collapsible, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

type OvermapDatumType = string;

type OvermapPosition = [
  number, // x
  number // y
];

type NameAndRef = {
  name: string;
  ref: string;
};

type Docked = NameAndRef[];

type OvermapDatumData = {
  name: string;
  ref: string;
  postition: [];
  docked_to?: NameAndRef;
  docked: Docked;
  token?: NameAndRef;
  ship_port_ref?: string;
};

type OvermapTokenManagerData = Record<OvermapDatumType, OvermapDatumData[]>;
enum DatumType {
  ship = '/datum/overmap/ship',
  event = '/datum/overmap/event',
  star = '/datum/overmap/star',
  all = '***',
}

const tokenTypeToName = (type: DatumType) => {
  switch (type) {
    case DatumType.ship:
      return 'Ship';
    case DatumType.event:
      return 'Event';
    case DatumType.star:
      return 'Star';
    case DatumType.all:
      return 'Everything';
    default:
      return 'Unknown';
  }
};

const VvButton = (props: { target_ref: string }, context: any) => {
  const { target_ref } = props;
  const { act } = useBackend(context);
  return (
    <Button
      icon="edit"
      tooltip="VV"
      onClick={() => act('vv', { ref: target_ref })}
    />
  );
};

const JumpButton = (
  props: { target_ref: string; tooltip_override?: string },
  context: any
) => {
  const { target_ref } = props;
  const { act } = useBackend(context);
  return (
    <Button
      icon="arrow-right"
      tooltip={props.tooltip_override || 'Jump to Token'}
      onClick={() => act('jump', { ref: target_ref })}
    />
  );
};

const TokenInfo = (props: { datum: OvermapDatumData }, context: any) => {
  const { act } = useBackend(context);
  const { datum } = props;
  return (
    <Collapsible title={datum.name}>
      <VvButton target_ref={datum.ref} />
      {datum.token && <JumpButton target_ref={datum.token.ref} />}
      {datum.ship_port_ref && (
        <JumpButton
          target_ref={datum.ship_port_ref}
          tooltip_override="Jump to Ship"
        />
      )}
      <Button
        icon="redo"
        tooltip="Reset Token"
        onClick={() => act('token-force-update', { ref: datum.ref })}
      />
      <Button
        icon="recycle"
        color="red"
        tooltip="Regenerate Token"
        onClick={() => act('token-new', { ref: datum.ref })}
      />
    </Collapsible>
  );
};

export const OvermapTokenManager = (_props: any, context: any) => {
  const { act, data } = useBackend<OvermapTokenManagerData>(context);
  const [activePane, setActivePane] = useLocalState<DatumType | undefined>(
    context,
    'activePane',
    undefined
  );

  const filteredData: OvermapDatumData[] = [];
  if (activePane) {
    for (const [type, tokens] of Object.entries(data)) {
      if (activePane === DatumType.all || type.includes(activePane as string)) {
        filteredData.push(...tokens);
      }
    }
  }
  filteredData.sort((a, b) => a.name.localeCompare(b.name));

  return (
    <Window title="Overmap Token Manager">
      <Window.Content scrollable>
        <Section title="Token Type">
          {Object.values(DatumType).map((type) => (
            <Button
              key={type}
              color={activePane === type ? 'green' : undefined}
              onClick={() => setActivePane(type as DatumType)}
              content={tokenTypeToName(type)}
            />
          ))}
        </Section>
        <Section
          title={`Tokens${
            (activePane && `(${filteredData.length}) - ${activePane}`) || ''
          }`}
        >
          {(activePane && (
            <Section>
              {filteredData.map((token) => (
                <TokenInfo key={token.ref} datum={token} />
              ))}
            </Section>
          )) || (
            <NoticeBox danger>
              Please select a token type from the tabs above.
            </NoticeBox>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
