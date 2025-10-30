import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Icon,
  Knob,
  LabeledControls,
  LabeledList,
  RoundGauge,
  Section,
  Tooltip,
} from 'tgui-core/components';
import { formatSiUnit } from 'tgui-core/format';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const formatPressure = (value) => {
  if (value < 10000) {
    return toFixed(value) + ' kPa';
  }
  return formatSiUnit(value * 1000, 1, 'Pa');
};

export const Canister = (props) => {
  const { act, data } = useBackend();
  const {
    portConnected,
    tankPressure,
    releasePressure,
    defaultReleasePressure,
    minReleasePressure,
    maxReleasePressure,
    valveOpen,
    isPrototype,
    hasHoldingTank,
    holdingTank,
    holdingTankLeakPressure,
    holdingTankFragPressure,
    restricted,
  } = data;
  return (
    <Window width={300} height={275}>
      <Window.Content>
        <Flex direction="column" height="100%">
          <Flex.Item mb={1}>
            <Section
              title="Canister"
              buttons={
                <>
                  {!!isPrototype && (
                    <Button
                      mr={1}
                      icon={restricted ? 'lock' : 'unlock'}
                      color="caution"
                      content={restricted ? 'Engineering' : 'Public'}
                      onClick={() => act('restricted')}
                    />
                  )}
                  <Button
                    icon="pencil-alt"
                    content="Relabel"
                    onClick={() => act('relabel')}
                  />
                </>
              }
            >
              <LabeledControls>
                <LabeledControls.Item minWidth="66px" label="Pressure">
                  <AnimatedNumber
                    value={tankPressure}
                    format={(value) => {
                      if (value < 10000) {
                        return toFixed(value) + ' kPa';
                      }
                      return formatSiUnit(value * 1000, 1, 'Pa');
                    }}
                  />
                </LabeledControls.Item>
                <LabeledControls.Item label="Regulator">
                  <Box position="relative" left="-8px">
                    <Knob
                      size={1.25}
                      color={!!valveOpen && 'yellow'}
                      value={releasePressure}
                      unit="kPa"
                      minValue={minReleasePressure}
                      maxValue={maxReleasePressure}
                      step={5}
                      stepPixelSize={1}
                      onDrag={(e, value) =>
                        act('pressure', {
                          pressure: value,
                        })
                      }
                    />
                    <Button
                      fluid
                      position="absolute"
                      top="-2px"
                      right="-20px"
                      color="transparent"
                      icon="fast-forward"
                      onClick={() =>
                        act('pressure', {
                          pressure: maxReleasePressure,
                        })
                      }
                    />
                    <Button
                      fluid
                      position="absolute"
                      top="16px"
                      right="-20px"
                      color="transparent"
                      icon="undo"
                      onClick={() =>
                        act('pressure', {
                          pressure: defaultReleasePressure,
                        })
                      }
                    />
                  </Box>
                </LabeledControls.Item>
                <LabeledControls.Item label="Valve">
                  <Button
                    my={0.5}
                    width="50px"
                    lineHeight={2}
                    fontSize="11px"
                    color={
                      valveOpen ? (hasHoldingTank ? 'caution' : 'danger') : null
                    }
                    content={valveOpen ? 'Open' : 'Closed'}
                    onClick={() => act('valve')}
                  />
                </LabeledControls.Item>
                <LabeledControls.Item mr={1} label="Port">
                  <Box position="relative">
                    <Icon
                      size={1.25}
                      name={portConnected ? 'plug' : 'times'}
                      color={portConnected ? 'good' : 'bad'}
                    />
                    <Tooltip
                      content={portConnected ? 'Connected' : 'Disconnected'}
                      position="top"
                    />
                  </Box>
                </LabeledControls.Item>
              </LabeledControls>
            </Section>
          </Flex.Item>
          <Flex.Item grow={1}>
            <Section
              height="100%"
              title="Holding Tank"
              buttons={
                !!hasHoldingTank && (
                  <Button
                    icon="eject"
                    color={valveOpen && 'danger'}
                    content="Eject"
                    onClick={() => act('eject')}
                  />
                )
              }
            >
              {!!hasHoldingTank && (
                <LabeledList>
                  <LabeledList.Item label="Label">
                    {holdingTank.name}
                  </LabeledList.Item>
                  <LabeledList.Item label="Pressure">
                    <RoundGauge
                      value={holdingTank.tankPressure}
                      minValue={0}
                      maxValue={holdingTankFragPressure * 1.15}
                      alertAfter={holdingTankLeakPressure}
                      ranges={{
                        good: [0, holdingTankLeakPressure],
                        average: [
                          holdingTankLeakPressure,
                          holdingTankFragPressure,
                        ],
                        bad: [
                          holdingTankFragPressure,
                          holdingTankFragPressure * 1.15,
                        ],
                      }}
                      format={formatPressure}
                      size={1.75}
                    />
                  </LabeledList.Item>
                </LabeledList>
              )}
              {!hasHoldingTank && <Box color="average">No Holding Tank</Box>}
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
