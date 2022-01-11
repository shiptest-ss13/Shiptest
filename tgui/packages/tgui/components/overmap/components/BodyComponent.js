import { CircleComponent } from './CircleComponent.js';
import { RectComponent } from './RectComponent.js';
import { SpriteComponent } from './SpriteComponent.js';
import { OrbitComponent } from './OrbitComponent.js';
import { PhysicsComponent } from './PhysicsComponent.js';

// TODO: move
// These must be kept in sync with the #DEFINEs in code/__DEFINES/overmap.dm
// If they fall out of sync, overmap bodies will break.
export const OVER_COMP_ID_CIRCLE = "circle";
export const OVER_COMP_ID_RECT = "rectangle";
export const OVER_COMP_ID_SPRITE = "sprite";
export const OVER_COMP_ID_ORBIT = "orbit";
export const OVER_COMP_ID_PHYSICS = "physics";

let compDict = null;

// TODO: document this, move? also use reflection instead of this bullshit
export function getCompTypeFromID(id) {
  const compList = [CircleComponent, RectComponent, SpriteComponent, OrbitComponent, PhysicsComponent];
  if (compDict === null) {
    compDict = {};
    for (const i in compList) {
      const compType = compList[i];
      if (compType.componentID() === null) {
        continue;
      }
      compDict[compType.componentID()] = compType;
    }
  }
  return compDict[id];
}

// TODO: document
export class BodyComponent {
  /// The component's ID, used to communicate attributes from
  /// BYOND to the client's UI. If null, component is considered
  /// "unnetworked" and must be added / updated / removed manually.
  // TODO: remove braces and simplifiy to just prototype?
  static componentID() { return null; }

  constructor(body) {
    this.parentBody = body;
    this.initComponent();
    return;
  }

  initComponent() {
    return;
  }

  readData(data) {
    return;
  }

  destroy() {
    return;
  }
}
