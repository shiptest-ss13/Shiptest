import { Graphics, Sprite, Matrix, utils } from 'pixi.js';
import { vecAdd, vecScale, vecLength } from 'common/vector';

import { createLogger } from '../../logging';
const logger = createLogger('backend');



// These must be kept in sync with the #DEFINEs in code/__DEFINES/overmap.dm
// If they fall out of sync, overmap bodies will break.
const OVER_COMP_ID_CIRCLE = "circle";
const OVER_COMP_ID_RECT = "rectangle";
const OVER_COMP_ID_SPRITE = "sprite";
const OVER_COMP_ID_ORBIT = "orbit";
const OVER_COMP_ID_PHYSICS = "physics";

// make this higher if you want circles / orbits to be less pointy
const DUMMY_RADIUS = 25;

export function locateBodyComponent(componentID) {
  switch (componentID) {
    case OVER_COMP_ID_CIRCLE:
      return CircleComponent;
    case OVER_COMP_ID_RECT:
      return RectangleComponent;
    case OVER_COMP_ID_SPRITE:
      return SpriteComponent;
    case OVER_COMP_ID_ORBIT:
      return OrbitComponent;
    case OVER_COMP_ID_PHYSICS:
      return PhysicsComponent;
  }
}


export class BodyComponent {
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

  runTick(dT) {
    return;
  }

  updateZoom(zoomLevel) {
    return;
  }

  destroy() {
    return;
  }
}


// data.radius
// data.color
export class CircleComponent extends BodyComponent {
  initComponent() {
    this.circle = new Graphics();
    this.circle.interactive = true;
    this.parentBody.visContainer.addChild(this.circle);
  }

  readData(data) {
    this.circle.clear();
    this.circle.beginFill(utils.string2hex(data.color));

    // so, the shape drawn by drawCircle isn't actually a circle, it's a polygon
    // that looks like a circle. the number of sides in that polygon scales with
    // the radius. we can't use the "true" radisus directly, since it's a
    // really small number; the shape ends up with very few sides. it doesn't
    // look like a circle. instead, we draw a circle with a larger radius, and
    // use a matrix to scale down the drawing.
    const scaleMatrix = new Matrix(data.radius/DUMMY_RADIUS, 0, 0, data.radius/DUMMY_RADIUS);
    this.circle.setMatrix(scaleMatrix);

    this.circle.drawCircle(0, 0, DUMMY_RADIUS);
    this.circle.endFill();
  }

  destroy() {
    this.circle.destroy();
    delete this.circle;
  }
}


// data.width
// data.height
// data.color
export class RectangleComponent extends BodyComponent {
  initComponent() {
    this.rectangle = new Graphics();
    this.rectangle.interactive = true;
    this.parentBody.visContainer.addChild(this.rectangle);
  }

  readData(data) {
    this.rectangle.clear();
    this.rectangle.beginFill(utils.string2hex(data.color));
    // drawRect draws from top left to bottom right, so we need to offset the starting location
    this.rectangle.drawRect(-data.width/2, -data.height/2, data.width, data.height)
    this.rectangle.endFill();
  }

  destroy() {
    this.rectangle.destroy();
    delete this.rectangle;
  }
}


// TODO: implement this
export class SpriteComponent extends BodyComponent {
  initComponent() {
    this.sprite = new Sprite();
    this.sprite.interactive = true;
    this.parentBody.visContainer.addChild(this.sprite);
  }

  readData(data) {

  }

  destroy() {
    this.sprite.destroy();
    delete this.sprite;
  }
}


// TODO: fix this to allow for natural satellites with correct orbits
export class OrbitComponent extends BodyComponent {
  initComponent() {
    this.orbit = new Graphics();
    this.parentBody.visContainer.parent.addChild(this.orbit);
  }

  readData(data) {
    // TODO: escape trajectory visualization
    if (data.oEccentricity >= 1) {
      return;
    }

    this.orbit.clear();
    // this width gets overridden in updateZoom (but if it's 0 the line hides)
    this.orbit.lineStyle({width: 1, color: 0x00FFFF, alpha: 1});
    // we've gotta do similar scaling fuckery to circles
    const scaleMatrix = new Matrix(1/DUMMY_RADIUS, 0, 0, 1/DUMMY_RADIUS);
    this.orbit.setMatrix(scaleMatrix);

    // draws the orbit's ellipse, with the focus of the orbit (the attractor) at 0,0
    const semiMinor = Math.sqrt(Math.pow(data.semi_major, 2)*(1-Math.pow(data.eccentricity, 2)));
    this.orbit.drawEllipse(-data.eccentricity*data.semi_major*DUMMY_RADIUS, 0, data.semi_major*DUMMY_RADIUS, semiMinor*DUMMY_RADIUS);

    this.orbit.angle = (data.counterclockwise ? -data.arg_of_periapsis : data.arg_of_periapsis);
  }

  updateZoom(zoomLevel) {
    // we scale the line width of each orbit down by the zoom level, so the width stays constant regardless of system zoom
    this.orbit.geometry.graphicsData.forEach(graphics => graphics.lineStyle.width = 1.625/zoomLevel);
  }

  destroy() {
    this.orbit.destroy();
    delete this.orbit;
  }
}


export class PhysicsComponent extends BodyComponent {
  readData(data) {
    // gotta flip the y
    this.velocity = [data.velocity[0], -data.velocity[1]];
    this.acceleration = [data.acceleration[0], -data.acceleration[1]];
  }

  runTick(dT) {
    const displacement = vecScale(vecAdd(this.velocity, vecScale(this.acceleration, dT/2)), dT);
    this.parentBody.visContainer.x += displacement[0];
    this.parentBody.visContainer.y += displacement[1];
    this.velocity = vecAdd(this.velocity, vecScale(this.acceleration, dT));
  }
}
