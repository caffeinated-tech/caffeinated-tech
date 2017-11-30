import React from 'react'
import ReactDOMServer from 'react-dom/server';
import express from 'express';
import App from './src/app.jsx';

const Server = express()
     
Server.use(express.static('dist'))

Server.get('/', (req, res) => {
	// TODO: sub html into index.html
	// or define html and source tags in react? - probably a good direction :)
	var html = ReactDOMServer.renderToStaticMarkup(React.createElement(App));
	console.log("html", html);
	res.send(html);
});


Server.listen(3000)