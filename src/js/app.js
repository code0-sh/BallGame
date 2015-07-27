'use strict';

var HelloReact = React.createClass({
  render() {
    return (
      <div className="container">Hello {this.props.name}</div>
    );
  }
});

React.render(<HelloReact name="React" />, document.getElementById("react"));