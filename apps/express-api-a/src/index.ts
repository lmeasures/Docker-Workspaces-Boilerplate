import cors from 'cors';
import express, { Request, Response } from 'express';

import  { sum } from '../../@csl/functions';

const app = express();
app.use(express.json());

app.use(cors());

const PORT = 3001;

app.get("/", (req: Request, res: Response) => {
    console.log("Hello World!");
    res.status(204).send({});
});

app.get("/status", (req, res) => {
    const status = {
        "Status": "Running"
    };
    res.status(200).send(status);
})

app.get("/sum", (req, res) => {
    const num1 = req.query.num1 as string;
    const num2 = req.query.num2 as string;
    const result = sum(+num1,+num2);
    res.status(200).send({result: result});
})

app.listen(PORT, () => {
    console.log("Server Listening on PORT: ", PORT);
})