#!/usr/bin/env coffee

Server = require('express')()
global.SEND_FILE_OPTIONS = 
  root: __dirname + '/views/',
  dotfiles: 'deny'
  headers: 
    'x-sent': true

require('./modules')(Server)

Server.set 'title', 'caffeinated.tech'
Server.get '/', (req,res) -> 
  res.redirect '/home'

Server.listen(8000)