import { Component, createRef } from 'inferno';
import { Application, Graphics, Matrix, Container, TextStyle, Text} from 'pixi.js';
import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, LabeledList, Knob, Input, Section, Grid, Box, ProgressBar, Slider, AnimatedNumber, Tooltip } from '../components';
import { refocusLayout, Window } from '../layouts';
import { Table } from '../components/Table';
import { ButtonInput } from '../components/Button';
import { createLogger } from '../logging';

const logger = createLogger('backend');

const obj_scale = 15

class OvermapDisplay extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
    this.pixiApp = null;
    this.sun = null;
    this.circle = null;
  }

  componentDidMount() {
    this._initDisplay();
    this.componentDidUpdate();
    return;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    const zoom_level = this.props.zoom_level * this.props.width / (4 * obj_scale);

    const size_matrix = new Matrix(zoom_level, 0, 0, zoom_level, this.sun.x, this.sun.y);

    this.sun.transform.setFromMatrix(size_matrix);

    this.circle.x = this.props.pos_x*obj_scale;
    this.circle.y = this.props.pos_y*obj_scale;

    this.circle.vel_x = this.props.vel_x*obj_scale;
    this.circle.vel_y = this.props.vel_y*obj_scale;

    this.circle.acc_x = this.props.acc_x*obj_scale;
    this.circle.acc_y = this.props.acc_y*obj_scale;

    logger.log(this.pixiApp.stage.toLocal(this.circle.getGlobalPosition()));
    logger.log(this.pixiApp.stage.position.x, this.pixiApp.stage.y);
    return;
  }

  componentWillUnmount() {
    return;
  }

  _initDisplay() {
    this.pixiApp = new Application({
      view: this.canvasRef.current,
      backgroundColor: 0x000000,
      width: this.props.width,
      height: this.props.height,
      antialias: true
    });

    this.sun = new Graphics();
    this.sun.beginFill(0xf6de01);
    this.sun.drawCircle(0, 0, 5);
    this.pixiApp.stage.addChild(this.sun);

    this.circle = new Graphics();
    this.circle.beginFill(0x9966FF);
    this.circle.drawCircle(0, 0, 2);
    this.sun.addChild(this.circle);

    this.pixiApp.stage.addChild(this.sun)

    const txt_style = new TextStyle({
      align:"center",
      fill:"#AAAAAA",
      fontSize:10
    });

    const the_text = new Text('Test string.', txt_style);
    this.circle.addChild(the_text);

    this.pixiApp.ticker.add(this._runPhysics, this);



    return;
  }

  _runPhysics() {
    if(!this.props.prediction) {
      return;
    }
    const t_scale = 10;

    const d_t = t_scale * this.pixiApp.ticker.deltaMS / 1000;

    this.circle.x += d_t*(this.circle.vel_x + (d_t*this.circle.acc_x/2));
    this.circle.y += d_t*(this.circle.vel_y + (d_t*this.circle.acc_y/2));

    this.circle.vel_x += d_t*this.circle.acc_x;
    this.circle.vel_y += d_t*this.circle.acc_y;

    /*
    const rel_to_origin = this.pixiApp.stage.toLocal(this.circle.getGlobalPosition());

    this.pixiApp.stage.x = 300 - rel_to_origin.x;
    this.pixiApp.stage.y = 300 - rel_to_origin.y;
    */

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
        prediction={data.prediction_test}
        zoom_level={data.zoom_level}
        pos_x={data.pos_x}
        pos_y={data.pos_y}
        vel_x={data.vel_x}
        vel_y={data.vel_y}
        acc_x={data.acc_x}
        acc_y={data.acc_y}/>
    </Window>
  );
};
