require('dotenv').config();
const express = require('express');
const con = require('./database');
const routes = require('./routes');

const app = express();

app.use(express.json());
app.use(routes);
app.listen(process.env.PORT, () => {
  console.log(`Server Started on port: ${process.env.PORT}`);
});

