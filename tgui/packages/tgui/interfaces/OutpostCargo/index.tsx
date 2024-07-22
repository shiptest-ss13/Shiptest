import { useBackend } from '../../backend';
import {
  Blink,
  Box,
  Button,
  Dimmer,
  Flex,
  Icon,
  Input,
  Modal,
  Section,
  TextArea,
  Tabs,
  Stack,
} from '../../components';
import { Window } from '../../layouts';

import { CargoCart } from './CargoCart';
import { CargoCatalog } from './CargoCatalog';
import { CargoData, SupplyPack } from './types';

export const OutpostCargo = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [] } = data;

  return (
    <Window width={800} height={700} resizable>
      <Window.Content>
        <Stack fill m="3px">
          <CargoCatalog />
          <CargoCart />
        </Stack>
      </Window.Content>
    </Window>
  );
};
