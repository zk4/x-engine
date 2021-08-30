var path = require("path");
const glob = require("glob");
const common = require("./webpack.config.js");

module.exports = {
  ...common,
  ...{
    // when debug in browser,  it will show the source
    devtool: "inline-source-map",
    mode: process.env.WEBPACK_MODE,
    entry: glob.sync("./h5/perf/*.js").map(function (file) {
      return path.resolve(__dirname, file);
    }),
    output: {
      // save the resulting bundle in the ./tmp/ directory
      path: path.resolve("./h5/tmp/perf/"),
      filename: "main.js",
    },
    plugins: [],
  },
};
