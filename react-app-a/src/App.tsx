import React from 'react';
import './App.css';
import { Components, Functions, Interfaces } from 'common';
import { IcChip } from '@ukic/react';
import { Button } from '@mui/material';

function App() {

  const [count, setCount] = React.useState(5);

  const callImportedFunction = () => {
    setCount(Functions.sum(count, count))
  }

  const implementComplexDataType: Interfaces.ComplexDataType = {
    a: 1,
    b: 2,
    c: "string",
    d: {
      d1: 1,
      d2: false,
    },
    e: () => {setCount(0)}
  }

  return (
    <div className="App"><br/>
      <IcChip label={`Count Value: ${count}`}/>  <br/><br/>
      <Components.Component1 parentStateValue={count} parentStateCallback={setCount}/>  <br/><br/>
      <Button variant="contained" onClick={()=> {callImportedFunction()}}>{count} + {count}</Button>  <br/><br/>
      <Button variant="outlined" onClick={() => {implementComplexDataType.e()}}>Use complexDataType implementation of 'e' (reset count)</Button>  <br/>
    </div>
  );
}

export default App;
