import { Component, createRef } from 'inferno';
import { Application, Graphics, Matrix, Container, ObservablePoint, LineStyle, utils, Text} from 'pixi.js';
import { vecAdd, vecScale, vecLength } from 'common/vector';
import { createLogger } from '../../logging';
import { getUpdateAppearance } from './BodyAppearance.js';

// TODO: redo data loading and parenting, OOB culling for perf, orbit line updating + disabling,
// TODO: escape orbits, text + popups, effects, sprites, a nice grid?, Rest Of The Fucking UI
// TODO: remove logger
const logger = createLogger('backend');

// make this higher if you want circles / orbits to be less pointy; explanation in OvermapBody.updateAppearance()

const LAYER_UI = 2;
const LAYER_SHIP = 1;
const LAYER_BODY = 0;
const LAYER_ORBIT = -1;

const DUMMY_RADIUS = 25;


class OvermapBody {
  constructor() {
    // TODO: maybe move the initialization here somewhere else?
    this.orbitContainer = new Graphics();
    this.orbitContainer.zIndex = LAYER_ORBIT;

    return;
  }

  parentToContainer(parentContainer) {
    parentContainer.addChild(this.visContainer);
    // TODO: a better understanding of what showOrbit actually is + does
    if(this.orbitContainer) {
      parentContainer.addChild(this.orbitContainer);
    }
  }

  loadFromData(bodyData) {
    this.updateAppearance = getUpdateAppearance(bodyData["appearance_type"]);

    this.visContainer = this.updateAppearance(this.visContainer, {
      radius: bodyData["radius"],
      color: utils.string2hex(bodyData["color"])
    });
    // TODO: move this
    this.visContainer.zIndex = LAYER_BODY;

    // load the position directly into the vis container
    this.visContainer.x = bodyData["position"][0];
    this.visContainer.y = bodyData["position"][1];
    this.velocity = bodyData["velocity"];
    this.acceleration = bodyData["acceleration"];

    // TODO: figure out a sensible understanding of what showOrbit means
    this.showOrbit = !!bodyData["show_orbit"];
    this.oSemiMajor = bodyData["o_semimajor"];
    this.oEccentricity = bodyData["o_eccentricity"];
    this.oCounterclockwise = bodyData["o_counterclockwise"];
    this.oArgOfPeriapsis = bodyData["o_arg_of_periapsis"];

    this.updateOrbit();
  }

  setOnClick(onClick, ourRef) {
    if(!onClick) {
      this.visContainer.interactive = false;
      return;
    }
    this.visContainer.interactive = true;
    this.visContainer.click = () => onClick(ourRef);
  }

  updateOrbit() {
    // TODO: figure out a sensible understanding of what showOrbit means
    if (!this.showOrbit) {
      return;
    }

    // TODO: escape trajectory visualization
    if (this.oEccentricity >= 1) {
      return;
    }

    this.orbitContainer.clear();
    // this width gets overridden in updateZoom (but if it's 0 the line hides)
    this.orbitContainer.lineStyle({width: 1, color: 0x00FFFF, alpha: 1});
    // TODO: fix this comment
    // we've gotta do the same scaling fuckery as in updateAppearance
    const scaleMatrix = new Matrix(1/DUMMY_RADIUS, 0, 0, 1/DUMMY_RADIUS);
    this.orbitContainer.setMatrix(scaleMatrix);

    // draws the orbit's ellipse, with the focus of the orbit (the attractor) at 0,0
    const semiMinor = Math.sqrt(Math.pow(this.oSemiMajor, 2)*(1-Math.pow(this.oEccentricity, 2)));
    this.orbitContainer.drawEllipse(-this.oEccentricity*this.oSemiMajor*DUMMY_RADIUS, 0, this.oSemiMajor*DUMMY_RADIUS, semiMinor*DUMMY_RADIUS);

    this.orbitContainer.angle = (this.oCounterclockwise ? -1*this.oArgOfPeriapsis : this.oArgOfPeriapsis);
  }

  updateZoom(zoomLevel) {
    // we scale the line width of each orbit down by the zoom level, so the width stays constant regardless of system zoom
    this.orbitContainer.geometry.graphicsData.forEach(graphics => graphics.lineStyle.width = 1.625/zoomLevel);
  }

  runTick(dT) {
    const displacement = vecScale(vecAdd(this.velocity, vecScale(this.acceleration, dT/2)), dT)
    this.visContainer.x += displacement[0];
    this.visContainer.y += displacement[1];
    this.velocity = vecAdd(this.velocity, vecScale(this.acceleration, dT));
  }

  cleanUp() {
    if (!!this.visContainer.parent) {
      this.visContainer.parent.removeChild(this.visContainer);
    }
    if (!!this.orbitContainer.parent) {
      this.orbitContainer.parent.removeChild(this.orbitContainer);
    }
    this.visContainer.destroy();
    this.orbitContainer.destroy();
    delete this.visContainer;
    delete this.orbitContainer;
  }
}

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
        // TODO: move
        newBody.loadFromData(bodyData);
        newBody.parentToContainer(this.systemAnchor);
        this.bodies[ref] = newBody;
        continue;
      }
      // TODO: move
      this.bodies[ref].loadFromData(bodyData);
      this.bodies[ref].setOnClick(this.props.onBodyClick, ref);
    }

    this.focusedBody = this.bodies[this.props.focusedBody];

    const zoomLevel = this.props.zoomLevel * Math.min(this.pixiApp.screen.width, this.pixiApp.screen.height) / 4;
    this.systemAnchor.scale.set(zoomLevel);

    for (const ref in this.bodies) {
      if (!this.props.bodyInformation[ref]) {
        this.bodies[ref].cleanUp();
        delete this.bodies[ref];
        continue;
      }
      this.bodies[ref].updateZoom(zoomLevel);
    }

    return;
  }

  _runTick() {
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
      this.bodies[ref].cleanUp();
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
