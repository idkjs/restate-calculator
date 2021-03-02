const path = require('path');

module.exports = {
  entry: {
    naive: './lib/js/src/Application.bs.js'
  },
  output: {
    path: path.join(__dirname, "bundledOutputs"),
    filename: '[name].js',
  },
};
