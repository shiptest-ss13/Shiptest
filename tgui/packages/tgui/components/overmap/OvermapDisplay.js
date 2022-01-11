import { Component, createRef } from 'inferno';
import { Application, Container } from 'pixi.js';
import { createLogger } from '../../logging';
import { RunTickEvent, ChangeZoomEvent } from '/Events.js';
import { OvermapBody } from './OvermapBody.js';
import { SelectedComponent } from './components/BodyComponent.js';
import { EventSystem } from './systems/EventSystem.js';
import { BodySystem } from './systems/BodySystem';
import { CameraSystem } from './systems/CameraSystem';

// TODO: move the entire damn directory
// TODO: redo data loading and parenting, OOB culling for perf,
// TODO: fixed satellite orbit tracking, escape orbits,
// TODO: text + popups, effects, sprites, a nice grid?, Rest Of The Fucking UI
// TODO: remove logger
const logger = createLogger('backend');

export class OvermapDisplay extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
    this.pixiApp = null;
    // TODO: remove
    // collection of all OvermapBodys, keyed by the ref used to identify the body
    this.bodies = {};
  }

  // TODO: move initDisplay into the constructor if possible? unsure how interfaces with createRef
  componentDidMount() {
    this.initDisplay();
    this.componentDidUpdate();
    return;
  }

  initDisplay() {
    // PIXI has a built-in system for click events, and we want to use it.
    // when it initializes, it checks "self.PointerEvent" to see if pointer events exist. if they do, it listens to them.
    // HOWEVER, for some reason i'm not sure of, pointer events don't get raised correctly in the tgui window.
    // so we need to set "self.PointerEvent" to null, then initialize PIXI, causing it to listen to mouse events (which ARE raised)
    // instead of pointer events (which are not). then we set "self.PointerEvent" back to its old value to prevent side-effects.
    // this sucks, and i'm sorry.
    const storedPointerEvent = self.PointerEvent;
    self.PointerEvent = null;
    this.pixiApp = new Application({
      view: this.canvasRef.current,
      resizeTo: this.canvasRef.current,
      backgroundColor: 0x000020,
      antialias: true
    });
    self.PointerEvent = storedPointerEvent;

    this.pixiApp.stage.addChild(CameraSystem.bodyContainer);

    this.pixiApp.ticker.add(this._runTick, this);
    return;
  }

  // TODO: graceful unfolding of props, default values???
  componentDidUpdate(prevProps, prevState, snapshot) {
    BodySystem.updateBodies(this.props.bodyInformation);

    // deselect old body / select new one, if applicable
    if (this.props.selectedBody !== prevProps.selectedBody) {
      if (!!this.selectedBody) {
        this.selectedBody.removeComponent(SelectedComponent);
      }
      this.selectedBody = BodySystem.getEntity(this.props.selectedBody);
      if (!!this.selectedBody) {
        this.selectedBody.addComponent(SelectedComponent);
      }
    }

    const newZoom = this.props.zoomLevel * Math.min(this.pixiApp.screen.width, this.pixiApp.screen.height);
    CameraSystem.updateZoom(newZoom);
    return;
  }

  _runTick() {
    // get the time change in seconds
    const dT = this.pixiApp.ticker.deltaMS / 1000;
    EventSystem.raiseEvent(RunTickEvent, dT);
    this._updateCameraLoc();
  }

  // TODO: move this to a system or something
  _updateCameraLoc() {
    // screen center point in px
    const centerPoint = {
      x: this.pixiApp.screen.width / 2,
      y: this.pixiApp.screen.height / 2
    };
    if (!!this.focusedBody) {
      const focusedScreenPos = this.focusedBody.visContainer.toGlobal({x:0, y:0});
      const sysPos = this.systemAnchor.toGlobal({x:0, y:0});
      centerPoint.x += sysPos.x - focusedScreenPos.x;
      centerPoint.y += sysPos.y - focusedScreenPos.y;
    }
    this.systemAnchor.position.copyFrom(centerPoint);
    return;
  }

  componentWillUnmount() {
    this._shutDown();
    return;
  }

  // TODO: rework this, make sure to clean up focusedBody / selectedBody etc.
  _shutDown() {
    this.pixiApp.ticker.remove(this._runTick, this);
    for (const ref in this.bodies) {
      this.bodies[ref].destroy();
      delete this.bodies[ref];
    }
    this.pixiApp.destroy(false, {
      children: true
    });
    return;
  }

  // TODO: move the styling info into CSS
  render() {
    return (
      <canvas
        ref={this.canvasRef}
        style={{
          'display': 'flex',
          'width': '100%',
          'height': '100%'
        }}
        {...this.props}>
        Canvas failed to render.
      </canvas>
    );
  }
}
