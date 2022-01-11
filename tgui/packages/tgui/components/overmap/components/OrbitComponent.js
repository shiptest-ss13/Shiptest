import { Graphics, Matrix, Ellipse, DEG_TO_RAD } from 'pixi.js';
import { EventSystem } from './events/EventSystem.js';
import { ChangeZoomEvent } from './events/Events.js';
import { BodyComponent, OVER_COMP_ID_ORBIT } from './BodyComponent.js';
import * as LAYERS from './Layers.js';

// TODO: document args
export class OrbitComponent extends BodyComponent {
  static componentID() { return OVER_COMP_ID_ORBIT; }

  initComponent() {
    this.orbit = new Graphics();
    this.orbit.zIndex = LAYERS.LAYER_ORBIT;
    this.parentBody.visContainer.addChild(this.orbit);

    // binding the method to ourselves so that we can more easily unsubscribe later
    this.updateZoom = (e) => this.updateZoom(e);
    EventSystem.subscribe(ChangeZoomEvent, this.updateZoom);
    return;
  }

  // TODO: unfolding?
  readData(data) {
    this.orbit.clear();
    // this width gets overridden in updateZoom (but if it's 0 the line hides)
    this.orbit.lineStyle({width: 1, color: 0x00FFFF, alpha: 1});

    // TODO: unfolding?
    data.orbits.forEach((orbit) => {
      // TODO: escape trajectory visualization
      if (orbit.eccentricity >= 1) {
        continue;
      }
      // draws the orbit's ellipse, with the attractor at 0,0 and the periapsis on the right
      const semiMinor = Math.sqrt(Math.pow(orbit.semi_major, 2)*(1-Math.pow(orbit.eccentricity, 2)));
      const orbitEllipse = new Ellipse(
        -orbit.eccentricity*orbit.semi_major,
        0,
        orbit.semi_major,
        semiMinor
      );
      // create a rotation matrix, used to rotate the ellipse we just created
      const orbitMatrix = new Matrix(1, 0, 0, 1);
      const degrees = (orbit.counterclockwise ? -orbit.arg_of_periapsis : orbit.arg_of_periapsis);
      orbitMatrix.rotate(degrees * DEG_TO_RAD);
      // we need to the orbit lines rotated individually; calling orbit.drawShape uses a shared matrix
      this.orbit.geometry.drawShape(
        orbitEllipse,
        this.orbit.fill.clone(),
        this.orbit.line.clone(),
        orbitMatrix
      );
    });
    this.orbit.geometry.invalidate();
    return;
  }

  updateZoom(zoomEvent) {
    const zoomLevel = zoomEvent.detail;
    // we scale the line width of each orbit down by the zoom level, so the width stays constant regardless of system zoom
    this.orbit.geometry.graphicsData.forEach(graphics => graphics.lineStyle.width = 1.625/zoomLevel);
    this.orbit.geometry.invalidate();
    return;
  }

  destroy() {
    EventSystem.unsubscribe(ChangeZoomEvent, this.updateZoom);
    this.orbit.destroy();
    delete this.orbit;
    return;
  }
}
