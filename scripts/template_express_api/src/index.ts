import cors from 'cors';
import express, { Request, Response } from 'express';

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

app.listen(PORT, () => {
    console.log("Server Listening on PORT: ", PORT);
})