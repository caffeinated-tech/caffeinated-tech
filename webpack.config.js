var config = {
  entry: './src/js/index.jsx', // entry point
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
      },
      {
        test: /\.scss$/,
        use: [
        {
            loader: "style-loader"
        },{
            loader: "css-loader"
        },{
            loader: "sass-loader" 
        }]
      },
      {
        test: /\.(woff2?|ttf|otf|eot|svg)$/,
        exclude: /node_modules/,
        loader: 'file-loader',
        options: {
            name: '[path][name].[ext]'
        }
      }
    ]
  }
};

module.exports = config;
