import { Graphics, utils } from 'pixi.js';
import { BodyComponent, OVER_COMP_ID_RECT } from './BodyComponent.js';

// data.width
// data.height
// data.color
export class RectComponent extends BodyComponent {
  static componentID() { return OVER_COMP_ID_RECT; }

  initComponent() {
    this.rectangle = new Graphics();
    this.rectangle.interactive = true;
    this.parentBody.visContainer.addChild(this.rectangle);
    return;
  }

  // TODO: unfolding?
  readData(data) {
    this.rectangle.clear();
    this.rectangle.beginFill(utils.string2hex(data.color));
    // drawRect draws from top left to bottom right, so we need to offset the starting location
    this.rectangle.drawRect(-data.width/2, -data.height/2, data.width, data.height);
    this.rectangle.endFill();
    return;
  }

  destroy() {
    this.rectangle.destroy();
    delete this.rectangle;
    return;
  }
}
