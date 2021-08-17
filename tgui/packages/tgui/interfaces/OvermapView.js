import { Component, createRef } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Button, ByondUi, LabeledList, Knob, Input, Section, Grid, Box, ProgressBar, Slider, AnimatedNumber, Tooltip } from '../components';
import { refocusLayout, Window } from '../layouts';
import { Table } from '../components/Table';
import { ButtonInput } from '../components/Button';

class OvermapDisplay extends Component {
  constructor(props) {
    super(props);
    this.canvasRef = createRef();
  }

  componentDidMount() {
    return;
  }

  componentDidUpdate(prevProps, prevState, snapshot) {
    return;
  }

  componentWillUnmount() {
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

export const OvermapView = (props, context) => {
  const {act, data, config} = useBackend(context);
  return (
    <Window resizable>
      <OvermapDisplay />
    </Window>
  );
};
