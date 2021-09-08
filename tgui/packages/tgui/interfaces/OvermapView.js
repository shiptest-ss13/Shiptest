import { Component, createRef } from 'inferno';
import { Application, Graphics, Matrix, Container, ObservablePoint, LineStyle, utils, Text} from 'pixi.js';
import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, LabeledList, Knob, Input, Section, Grid, Box, ProgressBar, Slider, AnimatedNumber, Tooltip } from '../components';
import { vecAdd, vecScale } from 'common/vector';
import { refocusLayout, Window } from '../layouts';
import { Table } from '../components/Table';
import { ButtonInput } from '../components/Button';
import { createLogger } from '../logging';
import { classes } from 'common/react';

// TODO: redo data loading and parenting, OOB culling for perf, orbits are slightly fucked for some reason, orbit line updating + disabling,
// TODO: escape orbits, movable camera, text + popups, effects, sprites, a nice grid, Rest Of The Fucking UI
const logger = createLogger('backend');

// make this higher if you want circles / orbits to be less pointy; explanation in OvermapBody.updateAppearance()
const DUMMY_RADIUS = 25;

const LAYER_UI = 2;
const LAYER_SHIP = 1;
const LAYER_BODY = 0;
const LAYER_ORBIT = -1;

class OvermapBody {
  constructor(bodyData) {
    // TODO: maybe move the initialization here somewhere else?
    this.visContainer = new Graphics();
    this.visContainer.sortableChildren = true; // enable layers on it
    this.visContainer.zIndex = LAYER_BODY;

    // TODO: maybe move the initialization here somewhere else?
    this.orbitContainer = new Graphics();
    this.orbitContainer.zIndex = LAYER_ORBIT;

    /* // TODO: use text
    this.testText = new Text("Test", {
      fontSize: 10,
      fill: 0xFF00FF,
      align: 'center'
    });
    this.testText.zIndex = 4;
    this.testText.anchor.set(0.5);
    */

    this.loadFromData(bodyData);
    return;
  }

  loadFromData(bodyData) {
    this.parentRef = bodyData["parent_ref"];

    // load the position directly into the vis container
    this.visContainer.x = bodyData["position"][0];
    this.visContainer.y = bodyData["position"][1];
    this.velocity = bodyData["velocity"];
    this.acceleration = bodyData["acceleration"];

    this.bodySize = bodyData["size"];
    this.bodyColor = utils.string2hex(bodyData["color"]);
    this.updateAppearance();

    // TODO: figure out a sensible understanding of what showOrbit means
    this.showOrbit = !!bodyData["show_orbit"];
    this.oSemiMajor = bodyData["o_semimajor"];
    this.oEccentricity = bodyData["o_eccentricity"];
    this.oCounterclockwise = bodyData["o_counterclockwise"];
    this.oArgOfPeriapsis = bodyData["o_arg_of_periapsis"];
    this.updateOrbit();
  }

  updateAppearance() {
    this.visContainer.clear();
    this.visContainer.beginFill(this.bodyColor);
    /*
    so, the shape drawn by the drawCircle method isn't actually a circle, it's a polygon that generally looks like a circle.
    the number of sides in that polygon scales with the radius. this means we can't use the body's "true" size directly, since
    it's a really small number; the shape ends up with very few sides, and if zoomed in, you can't even tell it's supposed to
    BE a circle. instead, we draw a circle with a larger radius, and use a matrix to scale down the drawing and ONLY the drawing.
    this way we have multiple zoom levels without either redrawing the circle for every zoom level or altering the coordinate system.
    */
    const scaleMatrix = new Matrix(this.bodySize/DUMMY_RADIUS, 0, 0, this.bodySize/DUMMY_RADIUS);
    this.visContainer.setMatrix(scaleMatrix);
    this.visContainer.drawCircle(0, 0, DUMMY_RADIUS);
    this.visContainer.endFill();
  }

  updateOrbit() {
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
    // we've gotta do the same scaling fuckery as in updateAppearance
    const scaleMatrix = new Matrix(1/DUMMY_RADIUS, 0, 0, 1/DUMMY_RADIUS);
    this.orbitContainer.setMatrix(scaleMatrix);

    // draws the orbit's ellipse, with the focus of the orbit (the attractor) at 0,0
    const semiMinor = Math.sqrt(Math.pow(this.oSemiMajor, 2)*(1-Math.pow(this.oEccentricity, 2)));
    this.orbitContainer.drawEllipse(-this.oEccentricity*this.oSemiMajor*DUMMY_RADIUS, 0, this.oSemiMajor*DUMMY_RADIUS, semiMinor*DUMMY_RADIUS);

    this.orbitContainer.angle = (this.oCounterclockwise ? -1*this.oArgOfPeriapsis : this.oArgOfPeriapsis);
  }

  parentToContainer(parentContainer) {
    parentContainer.addChild(this.visContainer);
    // TODO: better orbit parenting maybe?
    if (this.showOrbit) {
      parentContainer.addChild(this.orbitContainer);
    }
    // TODO: use text
    //this.visContainer.addChild(this.testText);

  }

  cleanUp() {
    if (!!this.visContainer.parent) {
      this.visContainer.parent.removeChild(this.visContainer);
    }
    if (!!this.orbitContainer.parent) {
      this.orbitContainer.parent.removeChild(this.orbitContainer);
    }
    /* // TODO: use text
    if (!!this.testText.parent) {
      this.testText.parent.removeChild(this.testText);
    }
    this.testText.destroy();
    this.testText = null;
    */
    this.visContainer.destroy();
    this.visContainer = null;
    this.orbitContainer.destroy();
    this.orbitContainer = null;
  }

  updateZoom(zoomLevel) {
    // we scale the line width of each orbit down by the zoom level, so the width stays constant regardless of system zoom
    this.orbitContainer.geometry.graphicsData.forEach(graphics => graphics.lineStyle.width = 1.625/zoomLevel);
    // TODO: use the text
    //this.testText.scale.set(1/zoomLevel);
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
    this.focusedBody = null;
    // collection of all OvermapBodys, keyed by the ref used to identify the body
    this.bodies = {};
  }

  componentDidMount() {
    this._initDisplay();
    this.componentDidUpdate();
    return;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    const zoomLevel = this.props.zoomLevel * this.pixiApp.screen.width / 4;
    this.pixiApp.stage.scale.set(zoomLevel);

    for (const ref in this.props.bodyInformation) {
      const bodyData = this.props.bodyInformation[ref];
      if (!this.bodies[ref]) {
        this.bodies[ref] = new OvermapBody(bodyData);
        continue;
      }
      this.bodies[ref].loadFromData(bodyData);
    }

    for (const ref in this.bodies) {
      this._processBodyParent(this.bodies[ref]);
      if (!this.props.bodyInformation[ref]) {
        this.bodies[ref].cleanUp();
        delete this.bodies[ref];
        continue;
      }
      this.bodies[ref].updateZoom(zoomLevel);
    }
    //this.focusedBody = this.bodies[this.props.focused];
    return;
  }

  componentWillUnmount() {
    this._shutDown();
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

  _initDisplay() {
    this.pixiApp = new Application({
      view: this.canvasRef.current,
      resizeTo: this.canvasRef.current,
      backgroundColor: 0x000020,
      antialias: true
    });
    this.pixiApp.ticker.add(this._runTick, this);
    return;
  }

  // we can't do this earlier, because we need to be sure that every body has been initialized
  _processBodyParent(body) {
    // TODO: reparenting
    if (!!body.visContainer.parent) {
      return;
    }
    // default container is the stage
    let parentContainer = this.pixiApp.stage;
    // if we have an actual parent, use it instead
    if (body.parentRef !== null) {
      parentContainer = this.bodies[body.parentRef].visContainer;
    }
    body.parentToContainer(parentContainer);
  }

  _runTick() {
    const dT = this.pixiApp.ticker.deltaMS / 1000;
    for (const ref in this.bodies) {
      this.bodies[ref].runTick(dT);
    }
    // TODO: use a listener so it doesn't have to update every single frame
    this._updateCamera();
  }

  _updateCamera() {
    const centerPoint = {x:this.pixiApp.screen.width / 2, y:this.pixiApp.screen.height / 2};
    if (!!this.focusedBody) {
      // TODO: this feels very roundabout. please torture yourself again and try to figure out how toGlobal and toLocal work. i'm sorry
      const focusedScreenPos = this.focusedBody.visContainer.toGlobal({x:0, y:0});
      const stagePos = this.pixiApp.stage.toGlobal({x:0, y:0});
      this.pixiApp.stage.position.copyFrom({x: centerPoint.x+stagePos.x-focusedScreenPos.x, y: centerPoint.y+stagePos.y-focusedScreenPos.y});
    } else {
      // nothing focused, just center the stage
      this.pixiApp.stage.position.copyFrom(centerPoint);
    }
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
}

const displaySize = 600;
export const OvermapView = (props, context) => {
  const { act, data, config } = useBackend(context);
  return (
    <Window
      width={displaySize+50}
      height={displaySize+50}
      resizable>
      <OvermapDisplay
        zoomLevel={data.zoom_level}
        bodyInformation={data.body_information}
        focused={data.focused_body}/>
    </Window>
  );
};
