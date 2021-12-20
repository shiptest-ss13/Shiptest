import { createLogger, logger } from '../../logging';
import { Graphics, Matrix, Container, ObservablePoint, LineStyle, utils, Text } from 'pixi.js';
import { locateBodyComponent } from './BodyComponent.js';
import { vecAdd, vecScale, vecLength } from 'common/vector';

const LAYER_UI = 2;
const LAYER_SHIP = 1;
const LAYER_BODY = 0;
const LAYER_ORBIT = -1;

export class OvermapBody {
  constructor() {
    this.visContainer = new Container();
    this.visContainer.zIndex = LAYER_BODY;
    // collection of all BodyComponents, keyed by their corresponding IDs
    this.components = {};
    return;
  }

  loadFromData(bodyData) {
    // load position directly into the vis container
    this.visContainer.x = bodyData["position"][0];
    // remember to flip the y
    this.visContainer.y = -bodyData["position"][1];

    // TODO: prettier way of doing this?
    for (const compID in bodyData["components"]) {
      const compData = bodyData["components"][compID];
      // if we don't have this component already
      if (!this.components[compID]) {
        const compType = locateBodyComponent(compID);
        // initialize it
        this.components[compID] = new compType(this);
      }
      this.components[compID].readData(compData);
    }
  }

  // TODO: make all of these use events
  runTick(dT) {
    for (const compID in this.components) {
      this.components[compID].runTick(dT);
    }
  }

  updateZoom(zoomLevel) {
    for (const compID in this.components) {
      this.components[compID].updateZoom(zoomLevel);
    }
  }

  setOnClick(onClick, ourRef) {
    if(!onClick) {
      this.visContainer.interactive = false;
      return;
    }
    this.visContainer.interactive = true;
    this.visContainer.click = () => onClick(ourRef);
  }

  destroy() {
    this.visContainer.destroy();
    delete this.visContainer;
    for (const compID in this.components) {
        this.components[compID].destroy();
    }
  }
}
