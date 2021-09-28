import { useBackend, useLocalState } from '../backend';
import { OvermapDisplay, Button } from '../components';
import { refocusLayout, Window } from '../layouts';

export const OvermapView = (props, context) => {
  const { act, data, config } = useBackend(context);
  const [zoomLevel, setZoomLevel] = useLocalState(context, 'zoomLevel', 1);
  const [focusedBody, setFocusedBody] = useLocalState(context, 'focusedBody', data.focused_body)
  return (
    <Window
      width={650}
      height={650}
      resizable>
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
    </Window>
  );
};
