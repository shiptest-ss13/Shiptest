import { Graphics, Sprite, Matrix, Rectangle, Ellipse, utils, DEG_TO_RAD } from 'pixi.js';
import { vecAdd, vecScale } from 'common/vector';
import { EventSystem } from './events/EventSystem.js';
import { RunTickEvent, ChangeZoomEvent } from './events/Events.js';
import { BodyComponent, OVER_COMP_ID_SPRITE } from './BodyComponent.js';

import * as LAYERS from './Layers.js';

// TODO: implement this, document args
export class SpriteComponent extends BodyComponent {
  static componentID() { return OVER_COMP_ID_SPRITE; }

  initComponent() {
    this.sprite = new Sprite();
    this.sprite.interactive = true;
    this.parentBody.visContainer.addChild(this.sprite);
    return;
  }

  readData(data) {
    return;
  }

  destroy() {
    this.sprite.destroy();
    delete this.sprite;
    return;
  }
}
