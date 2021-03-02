// const path = require('path');

// module.exports = {
//   entry: {
//     naive: './lib/js/src/Application.bs.js'
//   },
//   output: {
//     path: path.join(__dirname, "bundledOutputs"),
//     filename: '[name].js',
//   },
// };
const path = require("path");
const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const outputDir = path.join(__dirname, "dist/");

const isProd = process.env.NODE_ENV === "production";

module.exports = {
    mode: isProd ? "production" : "development",
    entry: {
        naive: "./src/Application.bs.js"
    },
    output: {
        path: outputDir,
        filename: "index.js",
        publicPath: "./"
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "public/index.html"
        })
    ],
    devServer: {
        compress: true,
        contentBase: outputDir,
        port: process.env.PORT || 8000,
        historyApiFallback: true,
        stats: "minimal"
    }
};
