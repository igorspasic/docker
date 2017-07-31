const http = require('http');
const os = require('os');
const express = require('express')

const PORT = 3333;

const app = express();
let healthCheck = true;
let count = 0;

const home = (req, res) => {
  count++;
  healthCheck ? res.status(200) : res.status(500);
  res.write(`Current healthcheck response : ${healthCheck}`);
  res.end();
}

app.get('/', home);

app.get('/switch', (req, res) => {
  healthCheck = (healthCheck == false)
  home(req, res);
})

app.get('/count', (req, res) => {
  res.write(`Healthcheck count : ${count}`);
  res.end();
})

app.listen(PORT);

console.log('Running on port ' + PORT);
