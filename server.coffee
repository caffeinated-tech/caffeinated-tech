#!/usr/bin/env coffee
express = require('express')
bodyParser = require('body-parser')

Server = express()

global.SEND_FILE_OPTIONS = 
  root: __dirname + '/public/views/',
  dotfiles: 'deny'
  headers: 
    'x-sent': true

Server.use(express.static('public'))
Server.use(bodyParser.json())
require('./modules')(Server)



Server.set 'title', 'caffeinated.tech'
Server.get '/', (req,res) -> 
  res.redirect '/v/home'

Server.listen(8000)