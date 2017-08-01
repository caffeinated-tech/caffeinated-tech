#!/usr/bin/env coffee
session = require("express-session");
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
uuidV1 = require('uuid/v1') 
global.express = require('express')
global.fs = require("fs")
global.EJS = require('ejs')
global.mongoose = require('mongoose')
global.Promise = require('promise')

showdown  = require('showdown')
global.Markdown = new showdown.Converter
Markdown.setOption 'ghCodeBlocks', true
mongoose.Promise = Promise
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

global.Models = require('./models/index')
global.Middleware = require('./middleware/index')
require('./modules')(Server)
require('./routers/index')(Server)

Server.set 'title', 'caffeinated.tech'


Server.listen(1337)