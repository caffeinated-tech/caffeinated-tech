#!/usr/bin/env coffee
express = require('express')
session = require("express-session");
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
global.mongoose = require('mongoose')
uuidV1 = require('uuid/v1')
 
mongoose.connect 'mongodb://localhost/caffeinated-tech'

Server = express()

global.SEND_FILE_OPTIONS = 
  root: __dirname + '/public/views/',
  dotfiles: 'deny'
  headers: 
    'x-sent': true

Server.use express.static('public')
Server.use cookieParser()
Server.use bodyParser.json()
Server.use session(
  genid: uuidV1
  secret: '1iOutbP721MdKINtHai5bzzAH8lrQMYe'
  name: 'session')

require('./modules')(Server)

Server.set 'title', 'caffeinated.tech'
Server.get '/', (req,res) -> 
  res.redirect '/v/home'

Server.listen(8000)