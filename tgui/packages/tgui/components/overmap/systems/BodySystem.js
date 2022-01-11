import { OvermapBody } from '../OvermapBody.js';
import { CameraSystem } from './CameraSystem.js';

export const BodySystem = new BodySystem();

// TODO: cleanup
class BodySystem {
  constructor() {
    // dict of bodies, keyed by their refs
    this.bodyDict = {};
  }

  // TODO: test to see if "...args" actually works on both sides
  addBody(ref, ...args) {
    if(!!this.getBody(ref)) {
      throw "Attempted to create a body with a duplicate ref!";
    }
    const body = new OvermapBody(ref, ...args);
    CameraSystem.bodyContainer.addChild(body.visContainer);
    this.bodyDict[ref] = body;
    return body;
  }

  deleteBody(body) {
    let bodyRef = null;
    // if it's a body, and not a ref, we need to get its ref
    if (body instanceof OvermapBody) {
      bodyRef = body.ref;
    } else {
      // we were (hopefully) given a ref
      bodyRef = body;
    }

    // the viscontainer removes itself from its parent automatically
    this.bodyDict[bodyRef].destroy();
    return delete this.bodyDict[ref];
  }

  getBody(ref) {
    return this.bodyDict[ref];
  }

  updateBodies(bodyDataDict) {
    for (const ref in bodyDataDict) {
      let body = this.getBody(ref);
      if (!body) {
        body = this.addBody(ref);
      }
      body.readData(bodyDataDict[ref]);
    }
    // now we delete all the bodies that didn't receive an update
    // this stops entities from ghosting on clients after deletion
    for (const ref in this.bodyDict) {
      if (!bodyDataDict[ref]) {
        this.deleteBody(ref);
      }
    }
    return;
  }
}
