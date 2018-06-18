// Config based on code from https://jlongster.com/Backend-Apps-with-Webpack--Part-I

const path = require('path');
const nodeExternals = require('webpack-node-externals');

module.exports = {
  entry: './src/index.js',
  target: 'node',
  mode: 'production',
  output: {
    path: path.join(__dirname, 'build'),
    filename: 'agent.js'
  },
  externals: [nodeExternals({
    whitelist: []
  })]
}