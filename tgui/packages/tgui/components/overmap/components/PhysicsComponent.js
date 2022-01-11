import { vecAdd, vecScale } from 'common/vector';
import { EventSystem } from './events/EventSystem.js';
import { RunTickEvent } from './events/Events.js';
import { BodyComponent, OVER_COMP_ID_PHYSICS } from './BodyComponent.js';

// TODO: document args
export class PhysicsComponent extends BodyComponent {
  static componentID() { return OVER_COMP_ID_PHYSICS; }

  initComponent() {
    // necessary to make unsubscription easier
    this.runTick = (e) => this.runTick(e);
    EventSystem.subscribe(RunTickEvent, this.runTick);
    return;
  }

  // TODO: unfolding?
  readData(data) {
    // gotta flip the y
    this.velocity = [data.velocity[0], -data.velocity[1]];
    this.acceleration = [data.acceleration[0], -data.acceleration[1]];
    return;
  }

  runTick(tickEvent) {
    const dT = tickEvent.detail;
    const displacement = vecScale(vecAdd(this.velocity, vecScale(this.acceleration, dT/2)), dT);
    this.parentBody.visContainer.x += displacement[0];
    this.parentBody.visContainer.y += displacement[1];
    this.velocity = vecAdd(this.velocity, vecScale(this.acceleration, dT));
    return;
  }

  destroy() {
    EventSystem.unsubscribe(RunTickEvent, this.runTick);
    return;
  }
}
