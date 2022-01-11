import { Container } from 'pixi.js';
import { BodySystem } from './BodySystem';
import { EventSystem } from './EventSystem';

export const CameraSystem = new CameraSystem();

// TODO: cleanup
class CameraSystem {
  constructor() {
    this.bodyContainer = new Container();
    this.zoomLevel = 1;
  }

  updateZoom(zoomLevel) {
    if (zoomLevel !== this.zoomLevel) {
      this.zoomLevel = zoomLevel;
      this.bodyContainer.scale.set(zoomLevel);
      EventSystem.raiseEvent(ChangeZoomEvent, zoomLevel);
    }
    return;
  }

  // TODO: finish; update the "this"es here to actually make sense
  updateCameraLoc() {
    // screen center point in px
    const centerPoint = {
      x: this.pixiApp.screen.width / 2,
      y: this.pixiApp.screen.height / 2
    };
    if (!!this.focusedBody) {
      const focusedScreenPos = this.focusedBody.visContainer.toGlobal({x:0, y:0});
      const sysPos = this.systemAnchor.toGlobal({x:0, y:0});
      centerPoint.x += sysPos.x - focusedScreenPos.x;
      centerPoint.y += sysPos.y - focusedScreenPos.y;
    }
    this.systemAnchor.position.copyFrom(centerPoint);

    // TODO: OOB body culling
    // TODO: add a simpler way of doing this, to BodySystem itself
    for (const bodyRef in BodySystem.bodyDict) {
      const body = BodySystem.bodyDict[bodyRef];
    }
    return;
  }

}
