var path = require("path");
const glob = require("glob");

const common = require("./webpack.config.js");

module.exports = {
  ...common,
  ...{
    // when debug in browser,  it will show the source
    devtool: "inline-source-map",
    //entry: glob.sync("./test/*_spec{,s}.js").map(function (file) {
    entry: glob.sync("./test/*.js").map(function (file) {
      return path.resolve(__dirname, file);
    }),
    output: {
      // save the resulting bundle in the ./tmp/ directory
      path: path.resolve("./tmp/test/"),
      filename: "main.js",
    },
  },
};
