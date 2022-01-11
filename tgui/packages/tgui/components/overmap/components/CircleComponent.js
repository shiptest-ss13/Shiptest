import { Graphics, Matrix, utils } from 'pixi.js';
import { BodyComponent, OVER_COMP_ID_CIRCLE } from './BodyComponent.js';

// TODO: remove?
// make this higher if you want circles / orbits to be less pointy
const DUMMY_RADIUS = 25;

// data.radius
// data.color
export class CircleComponent extends BodyComponent {
  static componentID() { return OVER_COMP_ID_CIRCLE; }

  initComponent() {
    this.circle = new Graphics();
    this.circle.interactive = true;
    this.parentBody.visContainer.addChild(this.circle);
    return;
  }

  // TODO: unfolding?
  readData(data) {
    this.circle.clear();
    this.circle.beginFill(utils.string2hex(data.color));

    // TODO: remove?
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
    return;
  }

  destroy() {
    this.circle.destroy();
    delete this.circle;
    return;
  }
}
