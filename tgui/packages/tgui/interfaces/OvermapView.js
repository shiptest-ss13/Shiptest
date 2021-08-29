import { Component, createRef } from 'inferno';
import { Application, Graphics, Matrix, Container, ObservablePoint, LineStyle, utils} from 'pixi.js';
import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, LabeledList, Knob, Input, Section, Grid, Box, ProgressBar, Slider, AnimatedNumber, Tooltip } from '../components';
import { vecAdd, vecScale } from 'common/vector';
import { refocusLayout, Window } from '../layouts';
import { Table } from '../components/Table';
import { ButtonInput } from '../components/Button';
import { createLogger } from '../logging';

/* TODO: redo data loading and parenting, culling (both due to omission and due to OOB), post-unmount cleanup, orbits are slightly fucked for some reason, */
/* TODO: orbit line updating + disabling, escape orbits, movable camera, variable window size, text + popups, effects, sprites, a nice grid, Rest Of The Fucking UI */
const logger = createLogger('backend');

/* make this higher if you want circles / orbits to be less pointy; explanation in OvermapBody.updateAppearance() */
const dummyRadius = 25;

const bodyLayer = 0;
const orbitLayer = -1;

class OvermapBody {
  constructor(bodyData) {
    /* TODO: maybe move the initialization here somewhere else? */
    this.visContainer = new Graphics();
    this.bodySize = null;
    this.bodyColor = null;
    this.parentRef = null;
    this.velocity = null;
    this.acceleration = null;

    /* TODO: maybe move the initialization here somewhere else? */
    /* orbit vars */
    this.orbitContainer = new Graphics();
    this.showOrbit = null; /* TODO: make this matter */
    this.oSemiMajor = null;
    this.oEccentricity = null;
    this.oCounterclockwise = null;
    this.oArgOfPeriapsis = null;

    this.loadFromData(bodyData);
    return;
  }

  /* TODO: this is ass. maybe try "..."? of course, that means defining the variables out-of-code... ugh*/
  loadFromData(bodyData) {
    /* most updates are just going to be physics updates, so normally redrawing isn't necessary */
    let redrawAppearance = false;
    if (this.bodySize !== bodyData["size"] ||
        this.bodyColor !== utils.string2hex(bodyData["color"])
      ) {
      redrawAppearance = true;
    }
    this.bodySize = bodyData["size"];
    this.bodyColor = utils.string2hex(bodyData["color"]);
    if (redrawAppearance) {
      this.updateAppearance();
    }

    this.parentRef = bodyData["parent_ref"];
    /* we just load the position data directly into the container itself */
    this.visContainer.x = bodyData["position"][0];
    this.visContainer.y = bodyData["position"][1];
    this.velocity = bodyData["velocity"];
    this.acceleration = bodyData["acceleration"];

    this.oSemiMajor = bodyData["o_semimajor"];
    this.oEccentricity = bodyData["o_eccentricity"];
    this.oCounterclockwise = bodyData["o_counterclockwise"];
    this.oArgOfPeriapsis = bodyData["o_arg_of_periapsis"];
    if (this.showOrbit !== !!bodyData["show_orbit"]) {
      this.showOrbit = !!bodyData["show_orbit"];
      this.updateOrbit();
    }
  }

  updateAppearance() {
    this.visContainer.sortableChildren = true;
    this.visContainer.zIndex = bodyLayer;
    this.visContainer.clear();
    this.visContainer.beginFill(this.bodyColor);
    /*
    so, the shape drawn by the drawCircle method isn't actually a circle, it's a polygon that generally looks like a circle.
    the number of sides in that polygon scales with the radius. this means we can't use the body's "true" size directly, since
    it's a really small number; the shape ends up with very few sides, and if zoomed in, you can't even tell it's supposed to
    BE a circle. instead, we draw a circle with a larger radius, and use a matrix to scale down the drawing and ONLY the drawing.
    this way we have multiple zoom levels without either redrawing the circle for every zoom level or altering the coordinate system.
    */
    const scaleMatrix = new Matrix(this.bodySize/dummyRadius, 0, 0, this.bodySize/dummyRadius);
    this.visContainer.setMatrix(scaleMatrix);
    this.visContainer.drawCircle(0, 0, dummyRadius);
    this.visContainer.endFill();
  }

  updateOrbit() {
    /* TODO: escape trajectory visualization */
    if (this.oEccentricity >= 1) {
      return;
    }

    this.orbitContainer.zIndex = orbitLayer;
    this.orbitContainer.clear();
    this.orbitContainer.lineStyle(0.011, 0x00FFFF, 1);
    /* we've gotta do the same scaling fuckery as in updateAppearance */
    const scaleMatrix = new Matrix(1/dummyRadius, 0, 0, 1/dummyRadius);
    this.orbitContainer.setMatrix(scaleMatrix);
    /* draws the orbit's ellipse, with the focus of the orbit (the attractor) at 0,0 */
    const semiMinor = Math.sqrt(Math.pow(this.oSemiMajor, 2)*(1-Math.pow(this.oEccentricity, 2)));
    this.orbitContainer.drawEllipse(-this.oEccentricity*this.oSemiMajor*dummyRadius, 0, this.oSemiMajor*dummyRadius, semiMinor*dummyRadius);

    this.orbitContainer.angle = (this.oCounterclockwise ? -1*this.oArgOfPeriapsis : this.oArgOfPeriapsis);
  }

  runTick(dT) {
    const displacement = vecScale(vecAdd(this.velocity, vecScale(this.acceleration, dT/2)), dT)
    this.visContainer.x += displacement[0];
    this.visContainer.y += displacement[1];

    this.velocity = vecAdd(this.velocity, vecScale(this.acceleration, dT));
  }
}


class OvermapDisplay extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
    this.pixiApp = null;
    /* collection of all OvermapBodys, keyed by the ref used in the corresponding body data array */
    this.bodies = {}
  }

  componentDidMount() {
    this._initDisplay();
    this.componentDidUpdate();
    return;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    this.props.bodyInformation.forEach(bodyData => this._processBodyData(bodyData));

    for (const ref in this.bodies) {
      this._processBodyParent(this.bodies[ref]);
    }

    this.pixiApp.stage.x = this.props.width / 2
    this.pixiApp.stage.y = this.props.height / 2

    const zoomLevel = this.props.zoomLevel * this.props.width / 4;

    this.pixiApp.stage.scale.set(zoomLevel);
    return;
  }

  componentWillUnmount() {
    this._shutDown();
    return;
  }

  render() {
    return (
      <canvas
        ref={this.canvasRef}
        {...this.props}>
        Canvas failed to render.
      </canvas>
    );
  }

  _initDisplay() {
    this.pixiApp = new Application({
      view: this.canvasRef.current,
      backgroundColor: 0x000000,
      width: this.props.width,
      height: this.props.height,
      antialias: true
    });
    this.pixiApp.ticker.add(this._runPhysics, this);
    return;
  }

  _shutDown() {
    this.pixiApp.ticker.remove(this._runPhysics, this)
  }

  _processBodyData(bodyData) {
    let bodyObject = this.bodies[bodyData["ref"]];
    if (!bodyObject) {
      bodyObject = new OvermapBody(bodyData);
      this.bodies[bodyData["ref"]] = bodyObject;
      return;
    }
    bodyObject.loadFromData(bodyData);
  }

  /* we can't do this in _processBodyData, because we need to be sure that every body has been initialized */
  _processBodyParent(body) {
    /* TODO: reparenting */
    if (!!body.visContainer.parent) {
      return;
    }
    /* no parent ref; the body is basal, and as such should be parented to the stage */
    if (body.parentRef === null) {
      this.pixiApp.stage.addChild(body.visContainer);
      return;
    }
    const referredBody = this.bodies[body.parentRef];
    /* the parent body couldn't be found, so we can't really place the child anywhere */
    if (!referredBody) {
      return;
    }
    referredBody.visContainer.addChild(body.visContainer);
    /* TODO: better orbit parenting */
    if(body.showOrbit) {
      referredBody.visContainer.addChild(body.orbitContainer);
    }
  }

  _runPhysics() {
    if (!this.props.interpolation) {
      return;
    }
    const dT = this.pixiApp.ticker.deltaMS / 1000;
    for (const ref in this.bodies) {
      this.bodies[ref].runTick(dT);
    }
  }
}

const displaySize = 600
export const OvermapView = (props, context) => {
  const { act, data, config } = useBackend(context);
  return (
    <Window
      width={displaySize+50}
      height={displaySize+50}
      resizable>
      <OvermapDisplay
        width={displaySize}
        height={displaySize}
        interpolation={data.interp_test}
        zoomLevel={data.zoom_level}
        bodyInformation={data.body_information}/>
    </Window>
  );
};
