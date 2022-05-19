import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {

  state = {
    contacts: [],
    quote: ""
  };

  componentDidMount() {
    const headers = { 'Content-Type': 'application/json' }

    fetch("http://BACKAPP:80/quote", {headers})
    .then(res => res.json())
    .then((data) => {
      this.setState({ quote: data })
    })
    .catch(console.log)
  }

  render() {
    return (
      <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        </header>
        <table>
          <tbody>
          <tr>
            <td>{this.state.quote.quote}</td>
            <td>{this.state.quote.author}</td>
          </tr>
          </tbody>
        </table>
      </div>      
    );
  }
}

export default App;
