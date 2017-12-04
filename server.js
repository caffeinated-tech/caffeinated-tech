import React from 'react'
import ReactDOMServer from 'react-dom/server';
import { StaticRouter } from 'react-router-dom';
import express from 'express';
import { ServerPage } from './src/app.jsx';

const Server = express()
console.log('ServerPage', ServerPage);
Server.use(express.static('dist'))

Server.get('*', (req, res) => {
	console.log(req.url);
	// var html = ReactDOMServer.renderToStaticMarkup(React.createElement(App));

	const context = {};
	var html = ReactDOMServer.renderToString(
		<StaticRouter location={ req.url } context={ context }>
			<ServerPage />
		</StaticRouter>
	);
	res.send(html);

  	// match({ routes: routes, location: req.url }, (err, redirect, props) => {
	// const appHtml = renderToString(<RouterContext {...props}/>)



	// };
});


Server.listen(3000)




// export default function serverRenderer({ clientStats, serverStats }) {
// 	return (req, res, next) => {
// 		const context = {};
// 		const markup = ReactDOMServer.renderToString(
// 			<StaticRouter location={ req.url } context={ context }>
// 				<App />
// 			</StaticRouter>
// 		);
//         const helmet = Helmet.renderStatic();

// 		res.status(200).send(Template({
// 			markup: markup,
//             helmet: helmet,
// 		}));
// 	};
// }