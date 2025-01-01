import { filter, sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { classes } from 'common/react';
import { createSearch } from 'common/string';
import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, Input, Section, Flex } from '../components';
import { NtosWindow } from '../layouts';
import {
  prevNextCamera,
  selectCameras,
  CameraConsoleContent,
} from './CameraConsole';

export const NtosSecurEye = (props, context) => {
  const { act, data, config } = useBackend(context);
  const { PC_device_theme, mapRef, activeCamera } = data;
  const cameras = selectCameras(data.cameras);
  const [prevCameraName, nextCameraName] = prevNextCamera(
    cameras,
    activeCamera
  );
  return (
    <NtosWindow width={800} height={600} theme={PC_device_theme}>
      <NtosWindow.Content>
        <div className="CameraConsole__left">
          <CameraConsoleContent />
        </div>
        <div className="CameraConsole__right">
          <div className="CameraConsole__toolbar">
            <b>Network: </b>
            {(data.network) || '—'}
            <b>{"\n"}</b>
            <b>Camera: </b>
            {(activeCamera && activeCamera.name) || '—'}
          </div>
          <div className="CameraConsole__toolbarRight">
            <Button
              icon="chevron-left"
              disabled={!prevCameraName}
              onClick={() =>
                act('switch_camera', {
                  name: prevCameraName,
                })
              }
            />
            <Button
              icon="chevron-right"
              disabled={!nextCameraName}
              onClick={() =>
                act('switch_camera', {
                  name: nextCameraName,
                })
              }
            />
          </div>
          <ByondUi
            className="CameraConsole__map"
            params={{
              id: mapRef,
              type: 'map',
            }}
          />
        </div>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
