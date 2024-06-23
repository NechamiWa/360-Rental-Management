require('dotenv').config();

const express = require('express');
const app = express();
const dbConfig = require('./config/dbConfig');
const appConfig = require('./config/appConfig');


app.listen(appConfig.port, () => {
    const port = appConfig.port;
    console.log(`app is listening on port ${port}`);
    console.log(`http://localhost:${port}`);
})
