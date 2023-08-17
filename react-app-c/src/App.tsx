import React from 'react';
import logo from './logo.svg';
import './App.css';
import { Components } from 'common';

function App() {

  const [count, setCount] = React.useState(5);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
      <h1>{count}</h1>
      <Components.Component1 parentStateValue={count} parentStateCallback={setCount}/>  <br/><br/>
    </div>
  );
}

export default App;
