import { createLogger } from '../../logging';
import { Container } from 'pixi.js';
import { getCompTypeFromID, BodyComponent } from './components/BodyComponent.js';
import * as LAYERS from './Layers.js';

const logger = createLogger('backend');

export class OvermapBody {
  constructor(ref) {
    this.ref = ref;
    this.visContainer = new Container();
    this.visContainer.zIndex = LAYERS.LAYER_BODY;
    this.visContainer.sortableChildren = true;

    // collection of all BodyComponents, keyed by their types
    this.components = {};
    return;
  }

  addComponent(compType, ...args) {
    if (!!this.getComponent(compType)) {
      throw "Attempted to add a component to a body that already had a component of specified type!";
    }
    this.components[compType] = new compType(this, ...args);
    return this.components[compType];
  }

  /// Deletes a component from the body. Accepts either a component itself or its type.
  deleteComponent(comp) {
    let compType = null;
    // if we were given a component instance, not a type
    if (comp instanceof BodyComponent) {
      compType = comp.constructor;
      // might've have been given a component of a type we possess, but which we do not have specifically
      if (comp !== this.components[compType]) {
        throw "Attempted to delete a component from a body that did not possess it!";
      }
    } else {
      // we were (hopefully) given a type
      compType = comp;
    }

    this.components[compType].destroy();
    return delete this.components[compType];
  }

  getComponent(compType) {
    return this.components[compType];
  }

  // TODO: elegant unfolding of bodyData
  readData(bodyData) {
    // load position directly into the vis container
    this.visContainer.x = bodyData["position"][0];
    // remember to flip the y
    this.visContainer.y = -bodyData["position"][1];
    const compDataDict = bodyData["components"];

    for (const compID in compDataDict) {
      const compType = getCompTypeFromID(compID);
      let comp = this.getComponent(compType);
      if (!comp) {
        comp = this.addComponent(compType);
      }
      comp.readData(compDataDict[compID]);
    }
    // delete all unnetworked components that didn't receive an update
    for (const compType in this.components) {
      const compID = compType.componentID();
      if (compID && !compDataDict[compID]) {
        this.deleteComponent(compType);
      }
    }
    return;
  }

  setOnClick(onClick) {
    if(!onClick) {
      this.visContainer.interactive = false;
      return;
    }
    this.visContainer.interactive = true;
    this.visContainer.click = () => onClick(this.ref);
    return;
  }

  destroy() {
    this.visContainer.destroy();
    delete this.visContainer;
    for (const compType in this.components) {
      this.deleteComponent(compType);
    }
    return;
  }
}
