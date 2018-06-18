var prompt = require('prompt');

prompt.start();

prompt.get(['input'], function (err, result) {
  console.log('Received input: ' + result.input);
});