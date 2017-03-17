#!/usr/bin/env coffee
express = require('express')
Server = express()

global.SEND_FILE_OPTIONS = 
  root: __dirname + '/public/views/',
  dotfiles: 'deny'
  headers: 
    'x-sent': true

require('./modules')(Server)


Server.use(express.static('public'))

Server.set 'title', 'caffeinated.tech'
Server.get '/', (req,res) -> 
  res.redirect '/home'

Server.listen(8000)