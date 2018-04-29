React  = require('react')
ReactDOMServer  = require('react-dom/server')
express  = require('express')

FullPage  = require('./src/js/full_page')

Server = express()
Server.use express.static('dist')

Server.get '*', (req, res) =>


  res.send html

Server.listen(3000)

