import React from 'react';
import logo from './logo.svg';
import './App.css';
import Components from 'common';

function App() {

  const [count, setCount] = React.useState(5);


  return (
    <div className="App">
      <h1>{count}</h1>
      <Components.Component1 parentStateValue={count} parentStateCallback={setCount}/>    
    </div>
  );
}

export default App;
