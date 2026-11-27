import { Section, LabeledList } from '../components';
import { useBackend } from '../backend';
import { useSharedState } from '../backend';
import { Window } from '../layouts';

import { CargoCatalog } from './OutpostCommunications/Catalog';

export const HandheldCatalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { outpostDocked, onShip, points } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', '');
  return (
    <Window width={600} height={700} resizable>
      <Window.Content scrollable>
        <CargoExpressContent />
      </Window.Content>
    </Window>
  );
};

export const CargoExpressContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { message } = data;
  return (
    <>
      <Section title="Outpost Catalog">
        <LabeledList>
          <LabeledList.Item label="Notice">{message}</LabeledList.Item>
        </LabeledList>
      </Section>
      <CargoCatalog />
    </>
  );
};
