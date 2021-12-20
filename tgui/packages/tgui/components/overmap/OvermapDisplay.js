import { Component, createRef } from 'inferno';
import { Application, Graphics, Matrix, Container, ObservablePoint, LineStyle, utils, Text} from 'pixi.js';
import { createLogger } from '../../logging';
import { OvermapBody } from './OvermapBody.js';

// TODO: redo data loading and parenting, OOB culling for perf,
// TODO: escape orbits, text + popups, effects, sprites, a nice grid?, Rest Of The Fucking UI
// TODO: remove logger
const logger = createLogger('backend');

export class OvermapDisplay extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
    this.pixiApp = null;
    // collection of all OvermapBodys, keyed by the ref used to identify the body
    this.bodies = {};
    // the parent container of all currently-visible bodies; can be scaled up and down without affecting global coords
    this.systemAnchor = null;

    this.focusedBody = null;
  }

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

    this.systemAnchor = new Container();
    this.systemAnchor.sortableChildren = true;

    this.pixiApp.stage.addChild(this.systemAnchor);

    this.pixiApp.ticker.add(this._runTick, this);
    return;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    for (const ref in this.props.bodyInformation) {
      const bodyData = this.props.bodyInformation[ref];
      if (!this.bodies[ref]) {
        const newBody = new OvermapBody();
        // TODO: maybe move this into OvermapBody's constructor
        this.systemAnchor.addChild(newBody.visContainer);
        this.bodies[ref] = newBody;
      }
      // TODO: move ?
      this.bodies[ref].loadFromData(bodyData);
      this.bodies[ref].setOnClick(this.props.onBodyClick, ref);
    }

    this.focusedBody = this.bodies[this.props.focusedBody];

    const zoomLevel = this.props.zoomLevel * Math.min(this.pixiApp.screen.width, this.pixiApp.screen.height) / 4;
    this.systemAnchor.scale.set(zoomLevel);

    for (const ref in this.bodies) {
      if (!this.props.bodyInformation[ref]) {
        this.bodies[ref].destroy();
        delete this.bodies[ref];
        continue;
      }
      this.bodies[ref].updateZoom(zoomLevel);
    }

    return;
  }

  _runTick() {
    // get the time change in seconds
    const dT = this.pixiApp.ticker.deltaMS / 1000;
    for (const ref in this.bodies) {
      this.bodies[ref].runTick(dT);
    }
    // TODO: use a listener so it doesn't have to update every single frame
    this._updateCameraLoc();
  }

  _updateCameraLoc() {
    const centerPoint = {x:this.pixiApp.screen.width / 2, y:this.pixiApp.screen.height / 2};
    if (!!this.focusedBody) {
      // TODO: this feels very roundabout. please torture yourself again and try to figure out how toGlobal and toLocal work. i'm sorry
      const focusedScreenPos = this.focusedBody.visContainer.toGlobal({x:0, y:0});
      const sysPos = this.systemAnchor.toGlobal({x:0, y:0});
      this.systemAnchor.position.copyFrom({x: centerPoint.x+sysPos.x-focusedScreenPos.x, y: centerPoint.y+sysPos.y-focusedScreenPos.y});
    } else {
      // nothing focused, just center the anchor
      this.systemAnchor.position.copyFrom(centerPoint);
    }
  }

  componentWillUnmount() {
    this._shutDown();
    return;
  }

  _shutDown() {
    this.pixiApp.ticker.remove(this._runTick, this);
    this.focusedBody = null;
    for (const ref in this.bodies) {
      this.bodies[ref].destroy();
      delete this.bodies[ref];
    }
    this.pixiApp.destroy(false, {
      children: true
    });
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
