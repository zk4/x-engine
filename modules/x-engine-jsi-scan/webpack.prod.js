const HtmlWebpackPlugin = require("html-webpack-plugin");
const common = require("./webpack.config.js");
module.exports = {
  ...common,
  entry: {
    main: "./h5/src/index.js",
  },
  optimization: {
    minimize: true,
  },
  devtool: false,

  plugins: [    
    new HtmlWebpackPlugin({
      title: "this is the title",
      template: "./h5/src/index.html",
    }),
],
};
