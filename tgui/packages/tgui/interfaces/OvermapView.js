import { useBackend, useLocalState } from '../backend';
import { refocusLayout, Window } from '../layouts';
import { OvermapDisplay, Button, Knob, NumberInput, Input, Section, Grid, Box, ProgressBar, Slider, AnimatedNumber, Tooltip, LabeledControls } from '../components';
import { Table } from '../components/Table';
import { createLogger } from '../logging';

const logger = createLogger('backend');

export const OvermapView = (props, context) => {
  const { act, data, config } = useBackend(context);
  const [zoomLevel, setZoomLevel] = useLocalState(context, 'zoomLevel', 1);
  const [focusedBody, setFocusedBody] = useLocalState(context, 'focusedBody', data.focused_body);
  return (
    <Window
      width={650}
      height={650}
      resizable>
      <div className="CameraConsole__left">
        <Window.Content>
          <ShipControls />
          <EngineList />
        </Window.Content>
      </div>
      <div className="CameraConsole__right">
        <Button
          icon="minus"
          onClick={() => setZoomLevel(zoomLevel*0.5)}/>
        <Button
          icon="plus"
          onClick={() => setZoomLevel(zoomLevel*2)}/>
        <Button
          icon="times"
          onClick={() => setFocusedBody(data.focused_body)}/>
        <OvermapDisplay
          zoomLevel={zoomLevel}
          bodyInformation={data.body_information}
          onBodyClick={(string) => setFocusedBody(string)}
          focusedBody={focusedBody}/>
      </div>
    </Window>
  );
};

const ShipControls = (props, context) => {
  const { act, data } = useBackend(context);
  const { heading, power } = data;
  return (
    <Section
      title="Navigation">
      <LabeledControls>
        <LabeledControls.Item
          label="Heading">
          <NumberInput
            suppressFlicker
            step={1}
            stepPixelSize={2}
            minValue={0}
            maxValue={359}
            value={heading}
            onDrag={(e, value) => act('heading', {
              heading: value,
            })} />
        </LabeledControls.Item>
        <LabeledControls.Item
          label="Engine Power">
          <Knob
            suppressFlicker
            size={1.25}
            color={!power && 'red'}
            step={0.01}
            stepPixelSize={5}
            minValue={0}
            maxValue={1}
            value={power}
            unit="%"
            format={value => Math.round(value*100)}
            onDrag={(e, value) => act('power', {
              power: value,
            })} />
        </LabeledControls.Item>
      </LabeledControls>
    </Section>
  );
};

const EngineList = (props, context) => {
  const { act, data } = useBackend(context);
  const { engine_info } = data;
  return (
    <Section
      title="Engines"
      buttons={(
        <Button
          tooltip="Refresh Engines"
          tooltipPosition="left"
          icon="sync"
          onClick={() => act('reload_engines')} />
    )}>
      <Table>
        <Table.Row bold>
          <Table.Cell collapsing>
            Name
          </Table.Cell>
          <Table.Cell fluid>
            Fuel
          </Table.Cell>
        </Table.Row>
        {engine_info && engine_info.map(engine => (
          <Table.Row
            key={engine.name}
            className="candystripe">
            <Table.Cell collapsing>
              <Button
                content={
                  (engine.name.len < 14) ? engine.name : engine.name.slice(0, 10) + "..."
                }
                color={engine.enabled && "good"}
                icon={engine.enabled ? "toggle-on" : "toggle-off"}
                tooltip="Toggle Engine"
                tooltipPosition="right"
                onClick={() => act('toggle_engine', {
                  engine: engine.ref,
                })} />
            </Table.Cell>
            <Table.Cell fluid>
              {engine.fuel !== null && (
                <ProgressBar
                  fluid
                  ranges={{
                    good: [.5, Infinity],
                    average: [.25, .5],
                    bad: [-Infinity, .25],
                  }}
                  maxValue={1}
                  minValue={0}
                  value={engine.fuel}>
                  <AnimatedNumber
                    value={engine.fuel * 100}
                    format={value => Math.round(value)} />
                  %
                </ProgressBar>
              ) || (
                <ProgressBar
                  fluid
                  color="grey"
                  maxValue={1}
                  minValue={0}
                  value={1}>
                  N/A
                </ProgressBar>
              )}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};
