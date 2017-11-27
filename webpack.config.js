var config = {
  entry: './src/index.jsx', // entry point
  output: {
    filename: './dist/index.js', // place where bundled app will be served
  },
  module: {
    loaders: [
      {
        test: /\.jsx?$/, // search for js files 
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react'] // use es2015 and react
        }
      }
    ]
  }
};

module.exports = config;