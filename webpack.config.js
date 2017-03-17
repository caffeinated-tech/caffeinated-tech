module.exports = {
  entry: "./public/scripts/source/index.coffee",
  output: {
      path: __dirname,
      filename: "public/scripts/index.js"
  },
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [
          {
            loader: 'coffee-loader',
            options: { sourceMap: true }
          }
        ]
      }
    ]
  }
}