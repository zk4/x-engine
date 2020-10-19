
const path = require("path");
// 用于引用webpack内置插件
const webpack = require("webpack");
// 外部插件
const HtmlWebpackPlugin = require("html-webpack-plugin");
const vConsolePlugin = require("vconsole-webpack-plugin");

module.exports = {
  mode:process.env.WEBPACK_MODE,
  devtool: "source-map",
  entry: {
    main: "./src/demo.js",
  },
  devServer: {
        hot: true,
        port: 3000,
        contentBase: './dist',
        open: true
    },
  output: {
    // [name] will follow the dir name
    filename: "[name].js",
    path: __dirname + "/dist",
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_module/,
        use: "babel-loader",
      },
      {
        test: /\.(png|svg|jpg|gif)$/,
        include: [path.resolve(__dirname, "src/components")],
        use: ["file-loader"],
      },
      {
        test: /\.css$/,
        include: [path.resolve(__dirname, "src/")],
        use: ["style-loader", "css-loader"], // 注意排列顺序，执行顺序与排列顺序相反
      },
    ],
  },
  plugins: [
    // auto reload
    new webpack.HotModuleReplacementPlugin(),
    // auto inject
    new HtmlWebpackPlugin({
      title: "this is the title",
      template: "./src/index.html",
    }),
    new vConsolePlugin({
      filter: [], // 需要过滤的入口文件
      enable: process.env.WEBPACK_MODE === "development", // 发布代码前记得改回 false
    }),
  ],
};
