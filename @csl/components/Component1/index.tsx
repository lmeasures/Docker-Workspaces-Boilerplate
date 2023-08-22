
import React from 'react';

interface IProps {
    parentStateValue: number,
    parentStateCallback: React.Dispatch<React.SetStateAction<number>>
}

export const Component1 = ({parentStateValue, parentStateCallback}: IProps) => {
    const [count, setCount] = React.useState(0);

    const AddCount = () => {
        setCount(count + 1);
        parentStateCallback(parentStateValue + 1);
    }

    return (
        <>
            <button onClick={()=>{AddCount()}}>{`+1! ${count}`}</button>
        </>
    )
}