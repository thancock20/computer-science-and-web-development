class FontChooser extends React.Component {

  constructor(props) {
  	super(props);

    const min = Number(this.props.min);
    const max = Number(this.props.max);
    const size = Number(this.props.size);
    const initialSize = size < min ? min : size > max ? max : size;
    const isRed = (initialSize === min || initialSize === max) ? true : false;

    // initial state
    this.state = {
      isHidden: true,
      isBold: this.props.bold === 'true' ? true : false,
      isRed,
      min: min > 0 ? min : 1,
      max: min < max ? max : min,
      initialSize,
      size: initialSize,
    };

    // bind event handlers
    this.handleBoldCheckbox = this.handleBoldCheckbox.bind(this);
    this.handleDecreaseButton = this.handleDecreaseButton.bind(this);
    this.handleFontSizeSpan = this.handleFontSizeSpan.bind(this);
    this.handleIncreaseButton = this.handleIncreaseButton.bind(this);
    this.handleTextSpan = this.handleTextSpan.bind(this);
  }

  handleBoldCheckbox() {
    this.setState({isBold: !this.state.isBold});
  }

  handleDecreaseButton() {
    if (this.state.size === this.state.min) return;
    this.setState({size: this.state.size - 1});
  }

  handleFontSizeSpan() {
    this.setState({size: this.state.initialSize});
  }

  handleIncreaseButton() {
    if (this.state.size === this.state.max) return;
    this.setState({size: this.state.size + 1});
  }

  handleTextSpan() {
    this.setState({isHidden: !this.state.isHidden});
  }

  render() {

    const color = [this.state.min, this.state.max].includes(this.state.size) ? 'red' : 'black';
    const fontWeight = this.state.isBold ? 'bold' : 'normal';

  	return (
      <div>
        <input
          type="checkbox"
          id="boldCheckbox"
          onChange={this.handleBoldCheckbox}
          checked={this.state.isBold}
          hidden={this.state.isHidden}
        />
        <button
          id="decreaseButton"
          onClick={this.handleDecreaseButton}
          hidden={this.state.isHidden}
        >-</button>
        <span
          id="fontSizeSpan"
          onDoubleClick={this.handleFontSizeSpan}
          style={{color}}
          hidden={this.state.isHidden}
        >{this.state.size}</span>
        <button
          id="increaseButton"
          onClick={this.handleIncreaseButton}
          hidden={this.state.isHidden}
        >+</button>
        <span
          id="textSpan"
          onClick={this.handleTextSpan}
          style={{ fontWeight, fontSize: this.state.size }}
        >{this.props.text}</span>
      </div>
  	);
  }
}
