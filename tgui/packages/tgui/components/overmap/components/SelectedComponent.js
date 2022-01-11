import { Graphics, Rectangle, } from 'pixi.js';
import { EventSystem } from './events/EventSystem.js';
import { RunTickEvent, ChangeZoomEvent } from './events/Events.js';
import { BodyComponent } from './BodyComponent.js';
import * as LAYERS from './Layers.js';

// no componentID / readData method because it's not networked
export class SelectedComponent extends BodyComponent {
  initComponent() {
    this.highlight = new Graphics();
    this.highlight.layer = LAYERS.LAYER_UI;
    this.parentBody.visContainer.addChild(this.highlight);

    // used to store the boundaries of the body selected, to check for updates
    this.boundRect = new Rectangle();

    this.updateRect = () => this.updateRect();
    this.updateZoom = (e) => this.updateZoom(e);
    EventSystem.subscribe(RunTickEvent, this.updateRect);
    EventSystem.subscribe(ChangeZoomEvent, this.updateZoom);
    return;
  }

  updateRect() {
    // we can't use the viscontainer's own bounds, because it recurses
    const testRect = this.parentBody.visContainer.children[0].getLocalBounds();

    // if they're the same, we don't need to change anything
    if (
      this.boundRect.x === testRect.x &&
      this.boundRect.y === testRect.y &&
      this.boundRect.width === testRect.width &&
      this.boundRect.height === testRect.height
    ) {
      return;
    }
    // they aren't the same, so we update our rect and draw
    this.boundRect.copyFrom(testRect);

    this.highlight.clear();
    // dummy width to make sure the thing actually renders
    this.highlight.lineStyle({width: 1, color: 0x00FFFF, alpha: 1});
    this.highlight.drawShape(this.boundRect);
    return;
  }

  updateZoom(zoomEvent) {
    const zoomLevel = zoomEvent.detail;
    this.highlight.geometry.graphicsData.forEach(graphics => graphics.lineStyle.width = 1.625/zoomLevel);
    this.highlight.geometry.invalidate();
    return;
  }

  destroy() {
    EventSystem.unsubscribe(RunTickEvent, this.updateRect);
    EventSystem.unsubscribe(ChangeZoomEvent, this.updateZoom);

    this.highlight.destroy();
    delete this.highlight;
    return;
  }
}
