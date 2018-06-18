const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('Script to run: ', (script) => {
  console.log(`Script to run is ${script}`);
  rl.close();
});