// Config based on code from https://jlongster.com/Backend-Apps-with-Webpack--Part-I

const path = require('path');
const fs = require('fs');

const nodeModules = {};
fs.readdirSync('node_modules')
  .filter(function(x) {
    return ['.bin'].indexOf(x) === -1;
  })
  .forEach(function(mod) {
    nodeModules[mod] = 'commonjs ' + mod;
  });

module.exports = {
  entry: './src/index.js',
  target: 'node',
  mode: 'production',
  output: {
    path: path.join(__dirname, 'build'),
    filename: 'agent.js'
  },
  externals: nodeModules
}