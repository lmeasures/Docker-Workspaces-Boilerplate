import React from 'react';
import './App.css';

import { Component1 } from '../../@csl/components';
import { sum } from '../../@csl/functions';
import { ComplexDataType } from '../../@csl/interfaces';

import { IcChip } from '@ukic/react';
import { Button } from '@mui/material';

function App() {

  const [count, setCount] = React.useState(5);

  const callImportedFunction = () => {
    setCount(sum(count, count))
  }

  const callApiImportedFunction = async (num1: number, num2: number) => {
    const result = await fetch(`http://localhost:3001/sum?num1=${num1}&num2=${num2}`, {
      method: 'GET',
      headers: {
        'content-type': 'application/json',
      }
    })
    .then(async (response) => {
      return (await response.json()).result;
    })
    .catch((e) => {
      console.error("Error occurred during maths: ", e);
      return 0;
    })
    setCount(result);
  }

  const implementComplexDataType: ComplexDataType = {
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
      <Component1 parentStateValue={count} parentStateCallback={setCount}/>  <br/><br/>
      <Button variant="contained" onClick={()=> {callImportedFunction()}}>{count} + {count}</Button>  <br/><br/>
      <Button variant="outlined" onClick={() => {implementComplexDataType.e()}}>Use complexDataType implementation of 'e' (reset count)</Button>  <br/>
      <Button variant="contained" onClick={()=> {callApiImportedFunction(count, count)}}>{count} + {count} using the API!</Button><br/>
    </div>
  );
}

export default App;
